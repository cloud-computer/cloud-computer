import { initTracer } from 'jaeger-client';

// returns a Tracer instance that will be given to initGlobalTracer
const initJaegerTracer = (serviceName: string) => {

  const config = {
    reporter: {
      logSpans: true,
    },
    serviceName,
    sampler: {
      type: 'const',
      param: 1,
    },
  };

  const options = {
    logger: {
      info (msg: string) {
        // console.error(`INFO ${msg} [${serviceName}] [${process.pid}]`);
      },
      error (msg: string) {
        // console.error('ERROR', msg);
      },
    },
  };

  return initTracer(config, options);
};

export const tracer = initJaegerTracer('yarn');
