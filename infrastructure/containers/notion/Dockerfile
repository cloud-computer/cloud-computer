FROM cloudnativecomputer/cloud-computer:latest

# Install notion
RUN git clone https://github.com/jaredallard/notion-app.git /opt/notion && \
  cd /opt/notion && \
  ./build.sh

# Start the application in vnc
CMD /cloud-computer/launcher-vnc.sh /opt/notion/tmp/build/electron /opt/notion/tmp/build/app.asar
