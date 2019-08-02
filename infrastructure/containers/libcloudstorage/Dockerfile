FROM ubuntu:19.04

# Install build dependencies
RUN apt-get update -qq && \
  apt-get install -qq \
  autoconf \
  curl \
  g++ \
  git \
  libcurl4-openssl-dev \
  libfuse3-dev \
  libjsoncpp-dev \
  libmicrohttpd-dev \
  libtinyxml2-dev \
  libtool \
  make \
  pkg-config \
  python \
  wget

# Build application
RUN git clone https://github.com/lemourin/libcloudstorage && \
  cd libcloudstorage && \
  ./bootstrap && \
  ./configure --with-curl --with-microhttpd --with-fuse && \
  make
