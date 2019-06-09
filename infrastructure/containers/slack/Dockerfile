FROM cloudnativecomputer/cloud-computer:latest

# Install slack
RUN wget --quiet https://downloads.slack-edge.com/linux_releases/slack-desktop-3.4.2-amd64.deb && \
  sudo dpkg -i slack-desktop-3.4.2-amd64.deb || \
  sudo apt-get install --fix-broken -qq && \
  rm slack-desktop-3.4.2-amd64.deb

# Start the application in vnc
CMD /cloud-computer/launcher-vnc.sh slack
