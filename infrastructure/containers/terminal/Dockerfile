FROM cloudnativecomputer/cloud-computer:latest

# Install tmuxinator
RUN sudo apt-get update -qq && \
  sudo apt-get install -qq ruby && \
  sudo gem install tmuxinator

# Add tmuxinator dashboard
ADD .tmuxinator.yml .

# Start tmuxinator
CMD tmuxinator start dashboard
