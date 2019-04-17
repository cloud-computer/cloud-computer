import { spawn } from 'child_process';
import { readJson } from 'fs-extra';
import { join, resolve as resolvePath } from 'path';

export interface ITask {
  /* The arguments passed to the yarn command. */
  args: string[];
  /* The script name in package.json, empty if native yarn command. */
  name: string | undefined;
  /* The command to be run. */
  command: string;
  /* The yarn --cwd argument. */
  cwd?: string;
  /* The directory the yarn command was invoked in. */
  pwd: string;
}

const cloudComputerYarn = resolvePath(__dirname, '../../../node_modules/@cloud-computer/yarn/bin/yarn');

export const getTask = async ({
  args = process.argv.slice(2),
  pwd = process.cwd(),
}: {
  args?: string[];
  pwd?: string;
} = {}): Promise<ITask> => {

  // limit to 3 elements to avoid child yarn arguments
  const cwd: string = args.slice(0, 2).includes('--cwd')
    ? args[args.indexOf('--cwd') + 1]
    : '';

  // set name based on presence of cwd
  const taskName: string = cwd
    ? args[args.indexOf('--cwd') + 2]
    : args[0];

  const getPackageJson = async (): Promise<any> => {
    const emptyPackageJson = { scripts: [] };
    const check: any = await readJson(resolvePath(pwd, cwd, 'package.json'))
      .catch(() => emptyPackageJson);
    return check;
  };

  const getCommand = async (name: string): Promise<string> => {
    const packageJson = await getPackageJson();

    if (!name) {

      return name;

    } else if (name === 'run') {

      const scriptName = cwd
        ? args[args.indexOf('--cwd') + 3]
        : args[1];

      return packageJson.scripts[scriptName];

    } else if (packageJson.scripts[name]) {

      return packageJson.scripts[name];

    } else {

      return name;

    }

  };

  const command = await getCommand(taskName);

  // Arguments must be wrapped in single quotes to preserve spaces
  const quoteSpaces = (arg: string) => arg.includes(' ')
    ? `'${arg}'`
    : arg;

  return {
    args: args.slice(args.indexOf(taskName) + 1).map(quoteSpaces),
    command,
    cwd,
    name: taskName === command
      ? undefined
      : taskName,
    pwd,
  };

};

export const executeTask = async ({ args, command, cwd = '', name, pwd }: ITask): Promise<any> => {

  // Include node_modules binaries in the task path
  const modulesPath = resolvePath(__dirname, '../../../node_modules/.bin');

  const spawnOpts = {
    cwd: join(pwd, cwd),
    shell: true,
    stdio: [0, 1, 2],
    env: {
      ...process.env,
      PATH: `${process.env.PATH}:${modulesPath}`,
    },
  };

  // Execute command directly, or delegate to original yarn
  const runningTask = !name
    ? spawn(cloudComputerYarn, [command, ...args], spawnOpts)
    : spawn(command, args, spawnOpts);

  const taskPromise: Promise<any> = new Promise((resolve) => {
    runningTask.on('exit', (exitCode: number) => resolve({ exitCode }));
  });

  return taskPromise;
};
