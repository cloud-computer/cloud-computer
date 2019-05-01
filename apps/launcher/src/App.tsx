import { Box, Button, Grommet, RangeInput, Select, Text } from 'grommet';
import React from 'react';
import GitHubLogin from 'react-github-login';

import { theme } from './theme';

// https://github.com/andreassolberg/jso
// https://github.com/zalando-stups/oauth2-client-js

interface AppState {
  cpu: number;
  ram: number;
  provider: string;
  githubToken: string;
};

const defaultState: AppState = {
  cpu: 8,
  ram: 32,
  provider: 'Google Cloud Platform',
  githubToken: '',
};

const providers = ['Amazon Web Services', 'Google Cloud Platform', 'Microsoft Azure'];
const cpuMax = 64;
const cpuMin = 1;
const ramMax = 128;
const ramMin = 1;

const App = () => {
  const [state, setState] = React.useState(defaultState);
  return (
    <Grommet theme={theme} full>

      <Box direction='row'>
      <Text>CPU</Text>
      <Text>{cpuMin}</Text>
        <RangeInput
          min={cpuMin}
          max={cpuMax}
          value={state.cpu}
          onChange={({ target }) => setState({ ...state, cpu: target.value })}
        ></RangeInput>
        <Text>{cpuMax}</Text>
      </Box>

      <Box direction='row'>
        <Text>RAM</Text>
        <Text>{ramMin}</Text>
        <RangeInput
          min={ramMin}
          max={ramMax}
          value={state.ram}
          onChange={({ target }) => setState({ ...state, ram: target.value })}
        ></RangeInput>
        <Text>{ramMax}</Text>
      </Box>
      
      <Box direction='row'>
        <Text>Provider</Text>
        <Select
          options={providers}
          value={state.provider}
          onChange={({ option }) => setState({ ...state, provider: option })}
        />
      </Box>

      <Box direction='row'>
        <Text>Authentication</Text>
        <GitHubLogin clientId='19e4afa3d26d99c30bcf'
          onSuccess={(response) => setState({ ...state, githubToken: response })}
          onFailure={() => {}}
          redirectUri='http://localhost:3000'
        />
      </Box>

      <Button
        label='Launch'
        onClick={() => console.log(state)}
      >
      </Button>

    </Grommet>
  );
}

export default App;
