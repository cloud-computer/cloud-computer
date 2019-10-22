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

# Use the cloud-computer launcher script
COPY --from=cloudnativecomputer/cloud-computer:latest /cloud-computer/launcher-vnc.sh /launcher-vnc.sh

# Change modifiers for web access
RUN sed -i 's/Mod4/Mod1/' $HOME/.config/i3/config

# Start the application in vnc
CMD /launcher-vnc.sh /usr/bin/i3
