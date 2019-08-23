# Restart the cloudstorage process whene
while true; do

  # Start the oauth http server and background it
  cloudstorage-fuse --add= &

  # Wait for oauth http server to start
  sleep 3

  # Start the fuse mount whose http server fails silently
  mkdir -p $CLOUD_COMPUTER_CLOUDSTORAGE/accounts
  cloudstorage-fuse -o allow_other,auto_unmount $CLOUD_COMPUTER_CLOUDSTORAGE/accounts

  # Wait until the oauth process exits
  wait -n

  # Gracefully terminate the cloudstorage fuse process
  kill -TERM $(pgrep cloudstorage)

  # Wait for cloudstorage fuse processes to exit
  while [ ! -z "$(pgrep cloudstorage)" ]; do
    sleep 1
  done

done
