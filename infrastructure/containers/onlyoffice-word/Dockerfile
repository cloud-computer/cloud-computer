FROM cloudnativecomputer/cloud-computer:latest

# Install onlyoffice
RUN wget --quiet https://download.onlyoffice.com/install/desktop/editors/linux/onlyoffice-desktopeditors_amd64.deb && \
  sudo apt-get update -qq && \
  sudo dpkg -i onlyoffice-desktopeditors_amd64.deb || \
  sudo apt-get install --fix-broken -qq && \
  rm onlyoffice-desktopeditors_amd64.deb

# Start the application in vnc
CMD /cloud-computer/launcher-vnc.sh "onlyoffice-desktopeditors --new:word"
