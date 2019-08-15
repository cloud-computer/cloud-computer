FROM cloudnativecomputer/cloud-computer:latest

# Install kicad
RUN sudo add-apt-repository ppa:js-reynaud/kicad-5.1 && \
  sudo apt-get update -qq && \
  DEBIAN_FRONTEND=noninteractive sudo apt-get install -qq --install-suggests kicad

# Install slack
RUN wget -O dispatch.tar.gz --quiet https://release.khlieng.com/khlieng/dispatch/linux_x64 && \
  tar xzf dispatch.tar.gz && \
  sudo mv dispatch /usr/local/bin
  rm dispatch.tar.gz

# Start the application
CMD dispatch
