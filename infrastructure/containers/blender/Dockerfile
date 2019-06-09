FROM cloudnativecomputer/cloud-computer:latest

# Install blender
RUN sudo apt-get update -qq && \
  sudo apt-get install -qq blender

# Start the application in vnc
CMD /cloud-computer/launcher-vnc.sh blender
