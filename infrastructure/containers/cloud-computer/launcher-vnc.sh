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
DISPLAY=$DISPLAY_XVFB $PROGRAM_TO_LAUNCH &

# Capture program window id
PROGRAM_WIDS=$(DISPLAY=$DISPLAY_XVFB xdotool search --onlyvisible --sync --class $PROGRAM_NAME)

# Align the program window to 0,0
echo $PROGRAM_WIDS | DISPLAY=$DISPLAY_XVFB xargs -n 1 -I @ xdotool windowmove @ 0 0

# Make the program window fullscreen
echo $PROGRAM_WIDS | DISPLAY=$DISPLAY_XVFB xargs -n 1 -I @ xdotool windowsize @ 100% 100%

# Start the vnc client
/opt/noVNC/utils/launch.sh --listen 8080
