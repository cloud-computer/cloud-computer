# Command line arguments
PROGRAM_NAME=$1

# Make the program fullscreen forever
while true; do

  # Make the program window fullscreen
  wmctrl -r "$1" -b add,fullscreen

  # Refresh regularly
  sleep 0.2

done
