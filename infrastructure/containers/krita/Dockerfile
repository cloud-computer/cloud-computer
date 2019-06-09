FROM cloudnativecomputer/cloud-computer:latest

# Install krita
RUN sudo add-apt-repository ppa:kritalime/ppa && \
  sudo apt-get update -qq && \
  sudo apt-get install -qq krita

# Start the application in vnc
CMD /cloud-computer/launcher-vnc.sh krita
