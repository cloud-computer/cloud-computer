# Command line arguments
PROGRAM_NAME=$1

# Make the program fullscreen forever
while true; do

  # Capture program window id
  PROGRAM_WIDS=$(xdotool search --onlyvisible --sync --class $PROGRAM_NAME)

  # Log action to be taken
  echo Making $PROGRAM_NAME fullscreen: $PROGRAM_WIDS

  # Align the program window to 0,0
  echo $PROGRAM_WIDS | xargs -n 1 -I @ xdotool windowmove @ 0 0

  # Make the program window fullscreen
  echo $PROGRAM_WIDS | xargs -n 1 -I @ xdotool windowsize @ 100% 100%

  # Be reasonable
  sleep 5

done
