FROM cloudnativecomputer/cloud-computer:latest

# Add key required to clone unreal engine
ADD id_rsa $HOME/.ssh/id_rsa
# RUN sudo chmod 600 $HOME/.ssh/id_rsa

# Install unreal engine
RUN git clone git@github.com:EpicGames/UnrealEngine.git --depth 1 && \
  cd UnrealEngine && \
  sudo apt-get update && \
  ./Setup.sh && \
  ./GenerateProjectFiles.sh && \
  make && \
  sudo make install

# Start the application in vnc
CMD /cloud-computer/launcher-vnc.sh "unreal" unreal
