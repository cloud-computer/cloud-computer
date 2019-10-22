FROM sabrehagen/desktop-environment:latest

# Use the cloud-computer launcher script
COPY --from=cloudnativecomputer/cloud-computer:latest /cloud-computer/launcher-vnc.sh /launcher-vnc.sh

# Start the application in vnc
CMD /launcher-vnc.sh /usr/bin/i3
