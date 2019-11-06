FROM cloudnativecomputer/cloud-computer:latest

# Install unrealengine
RUN git clone https://sabrehagen:fd6bb37484a2cf61f98d71a34bb48d1087908015@github.com/EpicGames/UnrealEngine.git --depth 1 && \
  cd UnrealEngine && \
  sudo apt-get update && \
  ./Setup.sh && \
  ./GenerateProjectFiles.sh && \
  make && \
  sudo make install

# Start the application in vnc
CMD /cloud-computer/launcher-vnc.sh "unreal" unreal
