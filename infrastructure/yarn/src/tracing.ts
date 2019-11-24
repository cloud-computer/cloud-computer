import { initTracer } from 'jaeger-client';

const { CLOUD_COMPUTER_DNS_NAME } = process.env;

// returns a Tracer instance that will be given to initGlobalTracer
const initJaegerTracer = (serviceName: string) => {

  const config = {
    reporter: {
      collectorEndpoint: `https://jaeger-collector.${CLOUD_COMPUTER_DNS_NAME}/api/traces`,
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
