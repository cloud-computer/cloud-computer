FROM cloudnativecomputer/cloud-computer:latest

# Install nvidia graphics card support
RUN sudo apt-get update -qq && \
  sudo apt-get install -qq nvidia-cuda-toolkit

# Install blender
RUN wget -O blender.tar.bz2 -qnv https://ftp.nluug.nl/pub/graphics/blender/release/Blender2.80/blender-2.80-linux-glibc217-x86_64.tar.bz2 && \
  tar xjf blender.tar.bz2 -C /opt --strip 1 && \
  rm blender.tar.bz2

# Start the application in vnc
CMD /cloud-computer/launcher-vnc.sh /opt/blender blender
