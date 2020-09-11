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

# Ensure container image sources are always available by using 'old' repositories
RUN sed -i -re 's/([a-z]{2}\.)?archive.ubuntu.com|security.ubuntu.com/old-releases.ubuntu.com/g' /etc/apt/sources.list

# Create a non-root user for safe operation
RUN useradd \
  --create-home \
  --groups $DOCKER_GROUP,shadow,sudo \
  --password $USER \
  --shell /bin/zsh \
  $USER

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
  asciinema \
  build-essential \
  cmake \
  cmatrix \
  ctop \
  curl \
  dnsutils \
  docker.io \
  figlet \
  g++ \
  gcc \
  git \
  gtk+3.0 \
  gosu \
  htop \
  iftop \
  iputils-ping \
  jq \
  libnss3-tools \
  lsb-core \
  make \
  man-db \
  nano \
  ncdu \
  net-tools \
  netcat-openbsd \
  nnn \
  numlockx \
  openbox \
  openssl \
  perl \
  python \
  ruby \
  software-properties-common \
  ssh \
  sudo \
  tigervnc-standalone-server \
  tmux \
  tree \
  vcsh \
  vim \
  weechat \
  wmctrl \
  xauth \
  xdotool \
  xinput \
  xsel \
  zsh

# Enable password-less sudo for the sudo group
RUN echo "%sudo ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers

# Install antigen
RUN curl -fsSL git.io/antigen > /usr/local/bin/antigen.zsh

# Install bat
RUN wget -O bat.deb -qnv https://github.com/sharkdp/bat/releases/download/v0.9.0/bat_0.9.0_amd64.deb && \
  dpkg -i bat.deb && \
  rm bat.deb

# Install ctop
RUN wget -O /usr/local/bin/ctop -qnv https://github.com/bcicen/ctop/releases/download/v0.7.2/ctop-0.7.2-linux-amd64 && \
  chmod +x /usr/local/bin/ctop

# Install define
RUN wget -O /usr/local/bin/define -qnv https://github.com/Rican7/define/releases/download/v0.1.2/define_linux_amd64 && \
  chmod +x /usr/local/bin/define

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

# Install git dashboard
RUN curl -fsSL https://github.com/jesseduffield/lazygit/releases/download/v0.7.2/lazygit_0.7.2_Linux_x86_64.tar.gz | \
  tar -C /usr/local/bin -xzf -

# Install git stats viewer
RUN git clone --depth 1 https://github.com/arzzen/git-quick-stats.git && \
  cd git-quick-stats && \
  make install && \
  rm -rf ../git-quick-stats

# Install go
RUN add-apt-repository ppa:longsleep/golang-backports && \
  apt-get update -qq && \
  apt-get install -qq golang-go

# Install gotop
RUN wget -qnv -O gotop-deb https://github.com/cjbassi/gotop/releases/download/3.0.0/gotop_3.0.0_linux_amd64.deb && \
  dpkg -i gotop-deb

# Install gotty
RUN curl -fsSL https://github.com/yudai/gotty/releases/download/v2.0.0-alpha.3/gotty_2.0.0-alpha.3_linux_amd64.tar.gz | \
  tar -C /usr/local/bin -xzf -

# Install gotty-client
RUN go get github.com/moul/gotty-client/cmd/gotty-client

# Install jump directory navigator
RUN wget -qnv -O jump.deb https://github.com/gsamokovarov/jump/releases/download/v0.22.0/jump_0.22.0_amd64.deb && \
  dpkg -i jump.deb && \
  rm jump.deb

# Install kind
RUN wget -qnv -O kind https://github.com/kubernetes-sigs/kind/releases/download/v0.3.0/kind-linux-amd64 && \
  chmod +x kind && \
  mv kind /usr/local/bin

# Install lazydocker
RUN curl -fsSL https://github.com/jesseduffield/lazydocker/releases/download/v0.2.4/lazydocker_0.2.4_Linux_x86_64.tar.gz | \
  tar -C /usr/local/bin -xzf -

# Install node.js
RUN curl -fsSL https://gist.githubusercontent.com/sabrehagen/b07846cdb0d373ad5e6a4c7567d5f390/raw/61b7273546d9b187c6ee77a902cd2d078de83fc7/install.sh | bash - && \
  apt-get install -qq nodejs

# Install novnc
RUN git clone --depth 1 https://github.com/cloud-computer/noVNC.git /opt/noVNC

# Install packer
RUN curl -fsSL https://releases.hashicorp.com/packer/1.3.3/packer_1.3.3_linux_amd64.zip > packer.zip && \
  unzip packer.zip && \
  mv packer /usr/local/bin && \
  rm packer.zip

# Install terraform
RUN wget --quiet https://releases.hashicorp.com/terraform/0.11.3/terraform_0.11.3_linux_amd64.zip && \
  unzip terraform_0.11.3_linux_amd64.zip && \
  mv terraform /usr/bin && \
  rm terraform_0.11.3_linux_amd64.zip

# Install tmuxinator
RUN gem install tmuxinator:1.1.1

# Install tmux plugin manager
RUN git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

# Install yarn
RUN curl -fsSL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update -qq && apt-get install -qq yarn

# Install yarn based utilities
RUN yarn global add \
  github-email \
  rebase-editor \
  tldr

# Ensure x server socket directory exists, owned by root, and world accessible
RUN mkdir -p /tmp/.X11-unix && \
   chmod 1777 /tmp/.X11-unix

# Add application launchers
ADD launcher-broadway.sh launcher-vnc.sh fullscreen-activewindow.sh fullscreen-always.sh /cloud-computer/

# Take ownership of user's home and applications directory
RUN chown -R $USER:$USER $HOME /opt

# Become non-root user
USER $USER
WORKDIR $HOME

# Clone dotfiles
RUN vcsh clone https://github.com/cloud-computer/dotfiles

# Cache tmux plugins
RUN zsh -c $HOME/.tmux/plugins/tpm/bin/install_plugins

# Cache zsh plugins
RUN zsh -c "source $HOME/.zshrc"

# Symlink cloud storage
RUN ln -s /cloud-computer/cloudstorage/cloud-storage/accounts/dropbox $HOME/Dropbox && \
  ln -s /cloud-computer/cloudstorage/cloud-storage/accounts/google $HOME/Google\ Drive && \
  ln -s /cloud-computer/cloudstorage/cloud-storage/accounts/onedrive $HOME/OneDrive

# Record container build metadata
ARG CONTAINER_BUILD_DATE
ARG CONTAINER_GIT_SHA
ENV CONTAINER_BUILD_DATE $CONTAINER_BUILD_DATE
ENV CONTAINER_GIT_SHA $CONTAINER_GIT_SHA
ENV CONTAINER_IMAGE_NAME cloud-computer/cloud-computer

# Run indefinitely
CMD sleep infinity
