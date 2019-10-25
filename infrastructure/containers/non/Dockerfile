FROM cloudnativecomputer/cloud-computer:latest

# Install non
RUN git clone git://git.tuxfamily.org/gitroot/non/non.git --depth 1 --single-branch && \
  cd non && \
  git submodule update --init && \
  cd lib/ntk && \
  sudo apt-get install -qq \
  ladspa-sdk \
  libcairo2-dev \
  libfontconfig1-dev \
  libjack-dev \
  libjpeg-dev \
  liblrdf0-dev \
  liblo-dev \
  libsigc++-2.0-dev \
  libsndfile1-dev \
  libxft-dev && \
  ./waf configure && \
  ./waf && \
  sudo su -c './waf install' && \
  cd ../.. && \
  ./waf configure && \
  ./waf && \
  sudo su -c './waf install'

# Start the application in vnc
CMD /cloud-computer/launcher-vnc.sh non
