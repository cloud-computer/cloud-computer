FROM ubuntu:19.04

# Install build dependencies
RUN apt-get update -qq && \
  apt-get install -qq \
  cmake \
  g++ \
  git \
  fuse3 \
  libboost-all-dev \
  libfuse3-3 \
  libfuse3-dev \
  libjemalloc-dev \
  libmongoc-dev \
  mongodb

# Install DriveFS
RUN git clone https://github.com/thejinx0r/DriveFS.git && \
  cd DriveFS && \
  git submodule init && \
  git submodule update && \
  mkdir build && \
  cd build && \
  DUSE_FUSE3=1 cmake .. && \
  make -j 8

# Start the application in vnc
CMD ./DriveFS
