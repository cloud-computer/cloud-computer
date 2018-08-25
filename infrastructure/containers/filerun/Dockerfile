FROM afian/filerun

# Symlink cloud storage
RUN echo "$(cat /entrypoint.sh | head -n -1)\n \
  ln -s /user-files/.cloudstorage/cloud-storage/accounts/dropbox /user-files/Dropbox && \
  ln -s /user-files/.cloudstorage/cloud-storage/accounts/google /user-files/Google\\ Drive && \
  ln -s /user-files/.cloudstorage/cloud-storage/accounts/onedrive /user-files/OneDrive\n\
  exec \"\$@\"" > /entrypoint.sh
