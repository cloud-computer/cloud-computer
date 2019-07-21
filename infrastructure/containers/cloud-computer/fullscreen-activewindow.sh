# Wait for window to load
sleep 10

# Capture active program window id
PROGRAM_WIDS=$(xdotool getactivewindow getwindowfocus)

# Align the program window to 0,0
echo $PROGRAM_WIDS | xargs -n 1 -I @ xdotool windowmove @ 0 0

# Make the program window fullscreen
echo $PROGRAM_WIDS | xargs -n 1 -I @ xdotool windowsize @ 100% 100%
