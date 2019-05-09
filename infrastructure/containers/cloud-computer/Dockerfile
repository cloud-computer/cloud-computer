FROM ubuntu:19.04

ENV USER cloud
ENV EDITOR nano
ENV HOME /home/$USER
ENV LANG en_US.UTF-8
ENV LANGUAGE $LANG
ENV LC_ALL $LANG
ENV LC_CTYPE $LANG
ENV SHELL /bin/zsh
ENV TERM xterm-256color
ENV TZ Australia/Sydney

# Restore minimized distribution content e.g. man pages
RUN yes | unminimize

# Install locales and timezone data
RUN apt-get update -qq && \
  apt-get install -qq \
  locales \
  tzdata

# Generate locales
RUN locale-gen $LANG && \
  update-locale LC_ALL=$LC_ALL LANG=$LANG && \
  dpkg-reconfigure --frontend=noninteractive locales

# Set timezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
  echo $TZ > /etc/timezone

# Install cloud computer utilities
RUN apt-get update -qq && \
  DEBIAN_FRONTEND=noninteractive apt-get install -qq --fix-missing \
  curl \
  dnsutils \
  docker.io \
  figlet \
  git \
  gosu \
  iputils-ping \
  jq \
  keychain \
  nano \
  ncdu \
  net-tools \
  nodejs \
  openbox \
  openssl \
  tmux \
  tree \
  unzip \
  vcsh \
  vim \
  wget \
  zsh

# Install antigen
RUN curl -fsSL git.io/antigen > /usr/local/bin/antigen.zsh

# Install bat
RUN wget -O bat.deb -qnv https://github.com/sharkdp/bat/releases/download/v0.9.0/bat_0.9.0_amd64.deb && \
  dpkg -i bat.deb && \
  rm bat.deb

# Install ctop
RUN wget -O /usr/local/bin/ctop -qnv https://github.com/bcicen/ctop/releases/download/v0.7.2/ctop-0.7.2-linux-amd64 && \
  chmod +x /usr/local/bin/ctop

# Install dive docker image explorer
RUN wget -qnv -O dive.deb https://github.com/wagoodman/dive/releases/download/v0.6.0/dive_0.6.0_linux_amd64.deb && \
  dpkg -i dive.deb && \
  rm dive.deb

# Install docker-compose
RUN curl -fsSL "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
  chmod +x /usr/local/bin/docker-compose

# Install fzf
RUN git clone --depth 1 https://github.com/junegunn/fzf.git /opt/fzf && \
  /opt/fzf/install --bin

# Install gotty
RUN curl -fsSL https://github.com/yudai/gotty/releases/download/v2.0.0-alpha.3/gotty_2.0.0-alpha.3_linux_amd64.tar.gz | \
  tar -C /usr/local/bin -xzf -

# Install gotop
RUN wget -qnv -O gotop-deb https://github.com/cjbassi/gotop/releases/download/3.0.0/gotop_3.0.0_linux_amd64.deb && \
  dpkg -i gotop-deb

# Install jump directory navigator
RUN wget -qnv -O jump.deb https://github.com/gsamokovarov/jump/releases/download/v0.22.0/jump_0.22.0_amd64.deb && \
  dpkg -i jump.deb && \
  rm jump.deb

# Install terraform
RUN curl -fsSL https://raw.githubusercontent.com/GoogleCloudPlatform/terraform-google-examples/master/terraform-install.sh | bash && \
  mv $HOME/bin/terraform /usr/local/bin && \
  rm -rf $HOME/bin

# Install tmux plugin manager
RUN git clone https://github.com/tmux-plugins/tpm /opt/tpm --depth 1 && \
  ln -s /opt/tpm/tpm /usr/local/bin

# Install yarn
RUN curl -fsSL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update -qq && apt-get install -qq yarn

# Install yarn based utilities
RUN yarn global add \
  clipboard-cli

# Enable password-less sudo for the sudo group
RUN echo "%sudo ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers

# Create the docker group with the host os group id
ENV DOCKER_GROUP 233
RUN groupmod --gid $DOCKER_GROUP docker

# Create a non-root user for safe operation
RUN useradd \
  --create-home \
  --groups $DOCKER_GROUP,sudo \
  --password $USER \
  --shell /bin/zsh \
  $USER

# Clone dotfiles
RUN vcsh clone https://github.com/cloud-computer/dotfiles

# Cache tmux plugins
RUN /opt/tpm/bin/install_plugins

# Take ownership of user's home and applications directory
RUN chown -R $USER:$USER $HOME /opt

# Cache zsh plugins
RUN gosu $USER zsh -c "source $HOME/.zshrc"

# Record container build metadata
ARG CONTAINER_BUILD_DATE
ARG CONTAINER_GIT_SHA
ENV CONTAINER_BUILD_DATE $CONTAINER_BUILD_DATE
ENV CONTAINER_GIT_SHA $CONTAINER_GIT_SHA
ENV CONTAINER_IMAGE_NAME cloud-computer/cloud-computer

# Become non-root user
USER $USER
WORKDIR $HOME

# Run indefinitely
CMD sleep infinity
