FROM sabrehagen/desktop-environment:latest

ENV DESKTOP_ENVIRONMENT_USER jackson
ENV USER cloud
ENV HOME /home/$USER

# Rename desktop user to cloud user
RUN sudo usermod -l $USER $DESKTOP_ENVIRONMENT_USER && \
  sudo usermod -d $HOME -m $USER && \
  sudo groupmod -n $USER $DESKTOP_ENVIRONMENT_USER

# Switch to cloud user
USER $USER

# Rewrite dotfiles home directory paths
RUN ls -d ~/.config/vcsh/repo.d/* | \
  xargs -n 1 -I @ sed -i "s/$DESKTOP_ENVIRONMENT_USER/$USER/" @/config

# Rebuild tmux extensions for cloud user
RUN ls -d ~/.tmux/plugins/* | \
  grep -v tpm | \
  xargs -n 1 -I @ rm -rf @; \
  zsh -c $HOME/.tmux/plugins/tpm/bin/install_plugins

# Rebuild zsh extensions for cloud user
RUN rm -f $HOME/.zcompdump && \
  zsh -c "source $HOME/.zshrc"

# Remap i3 modifiers for web access
RUN sed -i 's/Mod4/Mod1/' $HOME/.config/i3/config

# Disable compton and i3lock in web
RUN sed -i '/compton/d' $HOME/.config/i3/config
RUN sed -i '/i3lock/d' $HOME/.config/i3/config

# Clear code extension download history
RUN sed -i '/lastDownload/d' $HOME/.config/Code/User/syncLocalSettings.json

# Use the cloud-computer launcher script
COPY --from=cloudnativecomputer/cloud-computer:latest /cloud-computer/launcher-vnc.sh /launcher-vnc.sh

# Start the application in vnc
CMD /launcher-vnc.sh "zsh -c /usr/bin/i3"
