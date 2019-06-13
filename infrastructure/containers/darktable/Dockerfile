FROM cloudnativecomputer/cloud-computer:latest

# Install darktable
RUN sudo apt-get update -qq && \
  sudo apt-get install -qq darktable

# Use the broadway graphical environment
CMD /cloud-computer/launcher-broadway.sh darktable
