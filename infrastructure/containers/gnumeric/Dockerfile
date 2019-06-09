FROM cloudnativecomputer/cloud-computer:latest

# Install gnumeric
RUN sudo apt-get update -qq && \
  sudo apt-get install -qq gnumeric

# Start the application in broadway
CMD /cloud-computer/launcher-broadway.sh gnumeric
