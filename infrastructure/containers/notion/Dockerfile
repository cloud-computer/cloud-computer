FROM cloudnativecomputer/cloud-computer:latest

# Install notion
RUN sudo apt-get update -qq && \
  sudo apt-get install -qq p7zip-full dmg2img && \
  git clone --depth 1 https://github.com/jaredallard/notion-app.git /opt/notion && \
  cd /opt/notion && \
  ./build.sh

# Start the application in vnc
CMD /cloud-computer/launcher-vnc.sh "/opt/notion/tmp/build/electron /opt/notion/tmp/build/app.asar" notion
