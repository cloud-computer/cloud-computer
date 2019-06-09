FROM cloudnativecomputer/cloud-computer:latest

# Install inkscape
RUN sudo apt-get update -qq && \
  sudo apt-get install -qq inkscape

# Start the application in vnc
CMD /cloud-computer/launcher-vnc.sh inkscape
