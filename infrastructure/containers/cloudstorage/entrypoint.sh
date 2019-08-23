# Restart the cloudstorage process whene
while true; do

  # Start the oauth http server and background it
  cloudstorage-fuse --add= &

  # Wait for oauth http server to start
  sleep 3

  # Start the fuse mount
  mkdir -p $CLOUD_COMPUTER_CLOUDSTORAGE/accounts
  umount -l $CLOUD_COMPUTER_CLOUDSTORAGE/accounts
  cloudstorage-fuse -o allow_other,auto_unmount $CLOUD_COMPUTER_CLOUDSTORAGE/accounts

  # Wait until the oauth process exits
  wait -n

  # Wait for cloudstorage fuse processes to exit
  while [ ! -z "$(pgrep cloudstorage)" ]; do
    # Gracefully terminate the cloudstorage fuse process
    pgrep cloudstorage | xargs -n 1 -I @ kill -TERM @

    # Give cloudstorage process time to exit
    sleep 1
  done

done
