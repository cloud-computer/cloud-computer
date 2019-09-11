FROM cloudnativecomputer/cloud-computer:latest

# Install slack
RUN wget -O slack.deb --quiet https://downloads.slack-edge.com/linux_releases/slack-desktop-4.0.1-amd64.deb && \
  sudo dpkg -i slack.deb || \
  sudo apt-get install --fix-broken -qq && \
  rm slack.deb

# Start the application in vnc
CMD /cloud-computer/launcher-vnc.sh slack
