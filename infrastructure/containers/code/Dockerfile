FROM cloudnativecomputer/cloud-computer:latest

# Install code
RUN curl -fsSL https://github.com/cdr/code-server/releases/download/2.preview.4-vsc1.37.0/code-server2.preview.4-vsc1.37.0-linux-x86_64.tar.gz | \
  tar -C /tmp -xzf - && \
  sudo mv /tmp/code-server*/code-server /usr/local/bin && \
  rm -rf /tmp/code-server*

# Clone dotfiles configuration
RUN vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-code.git && \
  rsync -a $HOME/.config/Code/* $HOME/.config/code-server
