import { appendFile } from 'fs';
import { opentracing } from 'jaeger-client';

import { executeTask, getTask } from './task';
import { tracer } from './tracing';

const { FORMAT_TEXT_MAP } = opentracing;
const { CLOUD_COMPUTER_YARN_JAEGER_TRACE } = process.env;

export async function shim () {
  const task = await getTask();

  // Log debug information
  appendFile('/tmp/shim.log', `${JSON.stringify(task)}\n`, () => undefined);

  const getSpan = () => {

    if (!CLOUD_COMPUTER_YARN_JAEGER_TRACE) {
      return tracer.startSpan(task.command);
    }

    // inherit the span context from environment
    const context = tracer.extract(FORMAT_TEXT_MAP, JSON.parse(CLOUD_COMPUTER_YARN_JAEGER_TRACE));

    // choose which relationship of subspan to create
    const relationship = task.name
      ? 'childOf'
      : 'followsFrom';

    return tracer.startSpan(task.command, { [relationship]: context });
  };

  const span = getSpan();

  const outboundCarrier = {};
  tracer.inject(span, FORMAT_TEXT_MAP, outboundCarrier);

  // Propagate current span into the process environment
  process.env.CLOUD_COMPUTER_YARN_JAEGER_TRACE = JSON.stringify(outboundCarrier);

  span.setTag('processID', process.pid);
  span.setTag('name', task.name);
  span.setTag('cwd', task.cwd);
  span.setTag('pwd', process.cwd());

  const { exitCode, stderr } = await executeTask(task);

  if (exitCode) {
    span.setTag('error', true);

    span.log({
      event: 'stderr',
      value: stderr,
    });
  }

  span.finish();

  tracer.close();
}
