FROM cloudnativecomputer/cloud-computer:latest

# Install postman
RUN curl -fsSL https://dl.pstmn.io/download/latest/linux64 | \
  sudo tar -C /usr/local/bin -xzf - && \
  sudo ln -s /usr/local/bin/Postman/app/Postman /usr/local/bin/postman && \
  sudo apt-get install -qq libgconf-2-4

# Start the application in vnc
CMD /cloud-computer/launcher-vnc.sh postman
