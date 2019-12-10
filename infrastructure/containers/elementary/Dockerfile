FROM cloudnativecomputer/desktop:latest

# Install elementary desktop environment
RUN sudo touch /etc/apt/sources.list.d/elementary.list && \
  echo 'deb http://ppa.launchpad.net/elementary-os/os-patches/ubuntu bionic main' | sudo tee -a /etc/apt/sources.list.d/elementary.list && \
  echo 'deb-src http://ppa.launchpad.net/elementary-os/os-patches/ubuntu bionic main' | sudo tee -a /etc/apt/sources.list.d/elementary.list && \
  echo 'deb http://ppa.launchpad.net/elementary-os/stable/ubuntu bionic main' | sudo tee -a /etc/apt/sources.list.d/elementary.list && \
  echo 'deb-src http://ppa.launchpad.net/elementary-os/stable/ubuntu bionic main' | sudo tee -a /etc/apt/sources.list.d/elementary.list && \
  sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 6C8769CEDC20F5E66C3B7D37BF36996C4E1F8A59 && \
  sudo apt-get update -qq && \
	sudo apt-get dist-upgrade -qq && \
	sudo apt-get remove -qq gdm3 && \
	sudo apt-get install -qq --no-install-recommends elementary-sdk && \
  echo /usr/sbin/lightdm | sudo tee /etc/X11/default-display-manager && \
  sudo apt-get autoremove -qq && \
  sudo apt-get autoclean

# Start the application in vnc
CMD /launcher-vnc.sh "zsh -c startx"
