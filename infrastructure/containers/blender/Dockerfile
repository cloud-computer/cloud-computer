FROM cloudnativecomputer/cloud-computer:latest

# Install blender
RUN wget -O blender.tar.bz2 -qnv https://builder.blender.org/download/blender-2.81-cdeda1fa6cea-linux-glibc217-x86_64.tar.bz2 && \
  tar xjf blender.tar.bz2 -C /opt --strip 1 && \
  rm blender.tar.bz2

# Start the application in vnc
CMD /cloud-computer/launcher-vnc.sh /opt/blender blender
