FROM cloudnativecomputer/cloud-computer:latest

# Install skype
RUN wget --quiet https://go.skype.com/skypeforlinux-64.deb && \
  sudo dpkg -i skypeforlinux-64.deb && \
  rm skypeforlinux-64.deb

# Start the application in vnc
CMD /cloud-computer/launcher-vnc.sh skypeforlinux skype
