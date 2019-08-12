# Command line arguments
PROGRAM_TO_LAUNCH=$1
PROGRAM_NAME=${2-$1}

# Get the next available x display number
DISPLAY_XVFB=:$( (cd /tmp/.X11-unix && (for x in X*; do echo "${x#X}"; done) && echo 1) | awk '{s+=$1} END {print s}')

# Start an xvfb server
Xvfb -ac -nocursor -screen $DISPLAY_XVFB 1920x1080x24 $DISPLAY_XVFB &

# Wait until xvfb server is running before proceeding
until DISPLAY=$DISPLAY_XVFB xdpyinfo | grep -m 1 available >/dev/null; do sleep 1; done

# Start vnc server targeting the xvfb server
x11vnc -display $DISPLAY_XVFB -many -nopw -shared &

# Launch program on display
zsh -c "DISPLAY=$DISPLAY_XVFB $PROGRAM_TO_LAUNCH" &

# Start the vnc client
/opt/noVNC/utils/launch.sh --listen 8080 &

# Make the program window fullscreen
DISPLAY=$DISPLAY_XVFB /cloud-computer/fullscreen-always.sh $PROGRAM_NAME &

# Wait on running programs to handle exit codes
wait
