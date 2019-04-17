import { watch } from 'chokidar';
import * as constantCase from 'constant-case';
import { constants as fsModes, pathExists, readFile, stat } from 'fs-extra';
import { Docker } from 'node-docker-api';
import { Container } from 'node-docker-api/lib/container';
import { join, relative } from 'path';
import { pack as tarStream } from 'tar-stream';

const {
  COMPOSE_PROJECT_NAME = 'cloud-computer',
  DOCKER_HOST,
  HOSTNAME,
} = process.env;

// Use environment variable docker configuration if supplied
const docker = DOCKER_HOST
  ? new Docker(undefined)
  : new Docker({ socketPath: '/var/run/docker.sock' });

const repositories: string[] = [
  'cloud-computer',
  'frontend',
  'slackbot',
];

const repositoriesFolder = `${__dirname}/../../../..`;
const syncContainerName = `${COMPOSE_PROJECT_NAME}_cloud-computer-sync-${HOSTNAME}`;

const watchOptions = {
  ignored: /.git|build\/|node_modules/,
  ignoreInitial: true,
};

const getLocalRepositories = async (possibleRepositories: string[]) => {

  // Check if any optional repositories to sync are present on the local filesystem
  const repositoryChecks = possibleRepositories.map(async (repository) => {
    if (await pathExists(join(repositoriesFolder, repository))) {
      return repository;
    }
  });

  const repositoryResults = await Promise.all(repositoryChecks);
  const localRepositories: string[] = <any> repositoryResults.filter(Boolean);

  return localRepositories;
};

const createSyncContainer = async (repositoriesToSync: string[]) => {

  // Stop existing sync container to avoid duplicate tar streams
  const runningContainers = await docker.container.list({ all: true });
  const existingSyncContainer = runningContainers.find((container: any) => container.data.Names[0] === `/${syncContainerName}`);

  if (existingSyncContainer) {

    console.log('Stopping existing sync container...');

    await existingSyncContainer.delete({ force: true });
  }

  // Map a repository name to its docker volume mount format
  const repositoryVolumeName = (repository: string) => `${COMPOSE_PROJECT_NAME}_${constantCase(repository)}:/cloud-computer/${repository}`;

  // Create the sync container that will house the tar extraction streams
  const syncContainer = await docker.container.create({
    Binds: repositoriesToSync.map(repositoryVolumeName),
    Cmd: ['sleep', 'infinity'],
    Image: 'cloud-computer/cloud-computer:latest',
    name: syncContainerName,
  });

  // Start sync container
  await syncContainer.start();

  // Notify and exit when the sync container exits
  syncContainer.wait().then(() => {

    console.log('Sync container exited!');

    process.exit(0);
  });

  // Return the sync container for tar extraction streams to be created in
  return syncContainer;
};

const syncRepository = (repositoryName: string, syncContainer: Container) => {
  const repositoryPath = join(repositoriesFolder, repositoryName);

  const syncFile = async (path: string) => {
    const relativePath = relative(repositoryPath, path);
    const destinationPath = `/cloud-computer/${repositoryName}/${relativePath}`;
    const fileContents = await readFile(path);

    // Create a tar extractor pointng at the root of the filesystem
    const tarExtractorExec = await syncContainer.exec.create({
      AttachStdin: true,
      Cmd: ['tar', 'xf', '-'],
      OpenStdin: true,
      WorkingDir: '/',
    });

    // The receiving tar extractor stdio stream
    const { connection: tarExtractor } = <any> await tarExtractorExec.start();

    // The outgoing tar compression stream
    const tarCompressor = tarStream();

    // Pipe the tar compression stream to the standard input of the tar extractor
    tarCompressor.pipe(tarExtractor);

    // Sync the file to the cloud computer over the tar stream
    tarCompressor.entry({ name: destinationPath }, fileContents);

    // Cose the tar stream
    tarCompressor.finalize();

    // Check for executable mode on source file
    const fileStats = await stat(path);

    // tslint:disable-next-line
    const isExecutable = fileStats.mode & fsModes.S_IXUSR;

    // Apply executable mode if present on source file
    if (isExecutable) {
      const makeExecutable = await syncContainer.exec.create({
        Cmd: ['chmod', '+x', destinationPath],
      });

      await makeExecutable.start();
    }

    console.log(`Synced ${repositoryName} ${relativePath}`);
  };

  // Sync added and changed files
  watch(repositoryPath, watchOptions)
    .on('add', syncFile)
    .on('change', syncFile);

  console.log(`Watching ${repositoryName} for changes... (${repositoryPath})`);
};

const main = async () => {

  // Get the local repositories to sync
  const repositoriesToSync = await getLocalRepositories(repositories);

  // Create a container to sync to the local file system to the remote cloud computer
  const syncStream = await createSyncContainer(repositoriesToSync);

  // Sync all present repositories
  repositoriesToSync.forEach((repository) => syncRepository(repository, syncStream));
};

main();
