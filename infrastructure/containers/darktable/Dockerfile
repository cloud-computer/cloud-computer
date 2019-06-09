FROM cloudnativecomputer/cloud-computer:latest

# Install darktable
RUN sudo apt-get update -qq && \
  sudo apt-get install -qq darktable

# Use the broadway graphical environment
ENTRYPOINT /cloud-computer/launcher-broadway.sh

# Run darktable
CMD darktable
