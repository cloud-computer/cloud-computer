FROM cloudnativecomputer/cloud-computer:latest

# Install spotify
RUN sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90 && \
  echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list && \
  sudo apt-get update -qq && \
  sudo apt-get install -qq spotify-client

# Start the application in vnc
CMD /cloud-computer/launcher-vnc.sh spotify
