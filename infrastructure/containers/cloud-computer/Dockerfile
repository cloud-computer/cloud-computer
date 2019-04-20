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
  asciinema \
  build-essential \
  cloc \
  cmake \
  cmatrix \
  conky \
  curl \
  dnsutils \
  docker.io \
  feh \
  figlet \
  g++ \
  gcc \
  git \
  gosu \
  hsetroot \
  htop \
  iftop \
  iputils-ping \
  jq \
  keychain \
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
  proxytunnel \
  python \
  python-pip \
  rofi \
  rubygems \
  software-properties-common \
  ssh \
  strace \
  stress \
  sqlite3 \
  sxhkd \
  sudo \
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
  xserver-xephyr \
  xvfb \
  zsh

# Install antigen
RUN curl -fsSL git.io/antigen > /usr/local/bin/antigen.zsh

# Install arc
RUN wget -O /usr/local/bin/arc -qnv https://github.com/mholt/archiver/releases/download/v3.1.1/arc_linux_amd64 && \
  chmod +x /usr/local/bin/arc

# Install bat
RUN wget -O bat.deb -qnv https://github.com/sharkdp/bat/releases/download/v0.9.0/bat_0.9.0_amd64.deb && \
  dpkg -i bat.deb && \
  rm bat.deb

# Install ctop
RUN wget -O /usr/local/bin/ctop -qnv https://github.com/bcicen/ctop/releases/download/v0.7.1/ctop-0.7.1-linux-amd64 && \
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

# Install fd
RUN wget -qnv -O fd.deb https://github.com/sharkdp/fd/releases/download/v7.3.0/fd_7.3.0_amd64.deb && \
  dpkg -i fd.deb && \
  rm fd.deb

# Install fzf
RUN git clone --depth 1 https://github.com/junegunn/fzf.git /opt/fzf && \
  /opt/fzf/install --bin

# Install git dashboard
RUN curl -fsSL https://github.com/jesseduffield/lazygit/releases/download/v0.7.2/lazygit_0.7.2_Linux_x86_64.tar.gz | \
  tar -C /usr/local/bin -xzf -

# Install github hub
RUN curl -fsSL https://github.com/github/hub/releases/download/v2.7.0/hub-linux-amd64-2.7.0.tgz | \
  tar -C /tmp -xzf - && \
  /tmp/hub*/install && \
  rm -rf /tmp/hub*

# Install git stats viewer
RUN git clone https://github.com/arzzen/git-quick-stats.git && \
  cd git-quick-stats && \
  make install && \
  rm -rf ../git-quick-stats

# Install gotty
RUN curl -fsSL https://github.com/yudai/gotty/releases/download/v2.0.0-alpha.3/gotty_2.0.0-alpha.3_linux_amd64.tar.gz | \
  tar -C /usr/local/bin -xzf -

# Install gotop
RUN wget -qnv -O gotop-deb https://github.com/cjbassi/gotop/releases/download/3.0.0/gotop_3.0.0_linux_amd64.deb && \
  dpkg -i gotop-deb

# Install istioctl
RUN curl -fsSL https://github.com/istio/istio/releases/download/1.1.0-rc.2/istio-1.1.0-rc.2-linux.tar.gz | \
  tar -C /usr/local/bin -xzf -

# Install jump directory navigator
RUN wget -qnv -O jump.deb https://github.com/gsamokovarov/jump/releases/download/v0.22.0/jump_0.22.0_amd64.deb && \
  dpkg -i jump.deb && \
  rm jump.deb

# Install kubectl
RUN curl -fsSL -O https://storage.googleapis.com/kubernetes-release/release/$(curl -fsSL https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
  chmod +x kubectl && \
  mv kubectl /usr/local/bin

# Install kube prompt
RUN wget -qnv -O kube-prompt.zip https://github.com/c-bata/kube-prompt/releases/download/v1.0.5/kube-prompt_v1.0.5_linux_amd64.zip && \
  unzip kube-prompt.zip && rm kube-prompt.zip && \
  chmod +x kube-prompt && \
  mv kube-prompt /usr/local/bin

# Install node.js
RUN curl -fsSL https://gist.githubusercontent.com/sabrehagen/b07846cdb0d373ad5e6a4c7567d5f390/raw/61b7273546d9b187c6ee77a902cd2d078de83fc7/install.sh | bash - && \
  apt-get install -qq nodejs

# Install packer
RUN curl -fsSL https://releases.hashicorp.com/packer/1.3.3/packer_1.3.3_linux_amd64.zip > packer.zip && \
  unzip packer.zip && \
  mv packer /usr/local/bin && \
  rm packer.zip

# Install terraform
RUN curl -fsSL https://raw.githubusercontent.com/GoogleCloudPlatform/terraform-google-examples/master/terraform-install.sh | bash && \
  mv $HOME/bin/terraform /usr/local/bin && \
  rm -rf $HOME/bin

# Install tmuxinator
RUN gem install tmuxinator

# Install tmux plugin manager
RUN git clone https://github.com/tmux-plugins/tpm /opt/tpm --depth 1 && \
  ln -s /opt/tpm/tpm /usr/local/bin

# Install tmux notify
RUN wget -qnv -O /usr/local/bin/tmux-notify https://raw.githubusercontent.com/ssterling/tmux-notify/master/tmux-notify.sh && \
  chmod +x /usr/local/bin/tmux-notify

# Install webhookrelay
RUN wget -qnv -O /usr/local/bin/relay https://storage.googleapis.com/webhookrelay/downloads/relay-linux-amd64 && \
  chmod +x /usr/local/bin/relay

# Install weechat matrix plugin
RUN mkdir -p $HOME/.weechat/lua/autoload && \
  curl -fsSL "https://raw.githubusercontent.com/torhve/weechat-matrix-protocol-script/master/matrix.lua" -o $HOME/.weechat/lua/matrix.lua && \
  ln -s $HOME/.weechat/lua/matrix.lua $HOME/.weechat/lua/autoload && \
  apt-get install -qq lua-cjson

# Install weechat slack plugin
RUN mkdir -p $HOME/.weechat/python/autoload && \
  curl -fsSL "https://raw.githubusercontent.com/rawdigits/wee-slack/master/wee_slack.py" -o $HOME/.weechat/python/wee_slack.py && \
  ln -s $HOME/.weechat/python/wee_slack.py $HOME/.weechat/python/autoload && \
  pip install websocket-client

# Install yarn
RUN curl -fsSL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update -qq && apt-get install -qq yarn

# Install xeventbind
RUN wget -qnv -O /usr/local/bin/xeventbind https://github.com/sabrehagen/dotfiles-bin/raw/master/.bin/xeventbind && \
  chmod +x /usr/local/bin/xeventbind

# Install yarn based utilities
RUN yarn global add \
  @rafaelrinaldi/hn-cli \
  clipboard-cli \
  cloudflare-cli \
  github-email \
  imgur-uploader-cli \
  kubebox \
  majestic \
  rebase-editor \
  tldr

# Enable password-less sudo for the sudo group
RUN echo "%sudo ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers

# Create the docker group with the conventional docker group id
ENV DOCKER_GROUP 999
RUN groupmod --gid $DOCKER_GROUP docker

# Create a non-root user for safe operation
RUN useradd \
  --create-home \
  --groups $DOCKER_GROUP,sudo \
  --password $USER \
  --shell /bin/zsh \
  $USER

# Add user configuration files
COPY .conkyrc .gitconfig .gotty .tmux.conf .zlogin .zshenv .zshrc $HOME/

# Configure lazygit
RUN mkdir -p $HOME/.config/jesseduffield/lazygit && \
  echo 'reporting: "off"' > $HOME/.config/jesseduffield/lazygit/config.yml

# Configure openbox
RUN mkdir -p $HOME/.config/openbox
COPY .openbox.conf $HOME/.config/openbox/autostart
COPY .openbox.xml $HOME/.config/openbox/rc.xml
RUN chmod +x $HOME/.config/openbox/autostart && \
  git clone https://github.com/addy-dclxvi/openbox-theme-collections $HOME/.themes && \
  wget -qnv -O $HOME/.config/openbox/wallpaper.png https://images.unsplash.com/photo-1474910569322-ddc4a7368b8f

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
