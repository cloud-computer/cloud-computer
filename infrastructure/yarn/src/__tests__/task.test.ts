import { getTask } from '../task';

const repositoryRoot = `${__dirname}/../../../..`;

describe('Task API', () => {

  it('changes directories correctly', async () => {

    const task = await getTask({
      args: [
        '--cwd',
        'infrastructure/terraform',
        'ssh',
      ],
      pwd: repositoryRoot,
    });

    expect(task.cwd).toBe('infrastructure/terraform');
    expect(task.name).toBe('ssh');
    expect(task.command).toBe('yarn ssh:exec bash');

  });

  it('can recognize and delegate yarn commands', async () => {

    const task = await getTask({
      args: [
        'install',
      ],
    });

    expect(task.cwd).toBe('');
    expect(task.name).toBeUndefined();
    expect(task.command).toBe('install');
  });

  it('can pass through arguments to yarn command correctly', async () => {

    const task = await getTask({
      args: [
        '--cwd',
        'infrastructure/terraform',
        'terraform',
        'output',
        'ip',
      ],
      pwd: repositoryRoot,
    });

    expect(task.cwd).toBe('infrastructure/terraform');
    expect(task.name).toBe('terraform');
    expect(task.command).toBe('scripts/terraform.sh');
    expect(task.args).toMatchObject(['output', 'ip']);

  });

  it('can can handle single command args correctly', async () => {

    const task = await getTask({
      args: ['-v'],
      pwd: repositoryRoot,
    });

    expect(task.cwd).toBe('');
    expect(task.name).toBeUndefined();
    expect(task.command).toBe('-v');
  });

});
