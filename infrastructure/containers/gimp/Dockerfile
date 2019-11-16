FROM cloudnativecomputer/cloud-computer:latest

# Install gimp
RUN sudo apt-get update -qq && \
  sudo apt-get install -qq gimp

# Start the application in vnc
CMD /cloud-computer/launcher-vnc.sh gimp
