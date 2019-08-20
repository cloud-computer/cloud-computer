# Start the oauth http server and background it
cloudstorage-fuse --add= &

# Wait for oauth http server to start
sleep 5

# Start the fuse mount whose http server fails silently
cloudstorage-fuse -f /cloud-computer/cloudstorage &

# Wait until either process exits
wait -n
