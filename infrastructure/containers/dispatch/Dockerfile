FROM cloudnativecomputer/cloud-computer:latest

# Install dispatch
RUN wget -O dispatch.tar.gz --quiet https://release.khlieng.com/khlieng/dispatch/linux_x64 && \
  tar xzf dispatch.tar.gz && \
  sudo mv dispatch /usr/local/bin && \
  rm dispatch.tar.gz

# Start the application
CMD dispatch
