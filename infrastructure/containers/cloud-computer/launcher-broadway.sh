PROGRAM_TO_LAUNCH=$1

# Start the broadway daemon in the background
broadwayd &

# Start program rendering to broadway server
GDK_BACKEND=broadway $PROGRAM_TO_LAUNCH
