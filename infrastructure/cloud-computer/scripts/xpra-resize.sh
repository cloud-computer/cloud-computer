# Export cloud computer shell environment
eval "$(yarn environment)"

# Apply wallpaper based on current resolution
hsetroot -cover $HOME/.config/openbox/wallpaper.png

# X server window width
SERVER_WIDTH=$(DISPLAY=$CLOUD_COMPUTER_XPRA_DISPLAY xdotool getdisplaygeometry | cut -f 1 -d\ )

# Get the conky window id
CONKY_ID=$(DISPLAY=$CLOUD_COMPUTER_XEPHYR_DISPLAY xdotool search --onlyvisible --name conky)

# Early exit if conky is not found or there are multiple conkys
if [ -z "$CONKY_ID" ] || [ "${CONKY_ID#* }" != "$CONKY_ID" ]; then
  exit 0
fi

# Conky window geometry
CONKY_WIDTH=$(DISPLAY=$CLOUD_COMPUTER_XEPHYR_DISPLAY xdotool getwindowgeometry $CONKY_ID | grep Geometry | sed 's/.* //' | tr x ' ' | cut -f 1 -d\ )

# Calculate conky position
CONKY_NEW_X=$(($SERVER_WIDTH - $CONKY_WIDTH))

# Update conky window position
xdotool windowmove $CONKY_ID $CONKY_NEW_X 25
