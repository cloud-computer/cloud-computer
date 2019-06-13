FROM cloudnativecomputer/cloud-computer:latest

# Install kicad
RUN sudo add-apt-repository ppa:js-reynaud/kicad-5.1 && \
  sudo apt-get update -qq && \
  DEBIAN_FRONTEND=noninteractive sudo apt-get install -qq --install-suggests kicad

# Start the application in vnc
CMD /cloud-computer/launcher-vnc.sh kicad
