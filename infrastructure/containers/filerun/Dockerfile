FROM afian/filerun

# Symlink cloud storage, automatically log in as superuser
RUN echo "$(cat /entrypoint.sh | head -n -1)\n \
  ln -s /user-files/.cloudstorage/cloud-storage/accounts/dropbox /user-files/Dropbox && \
  ln -s /user-files/.cloudstorage/cloud-storage/accounts/google /user-files/Google\\ Drive && \
  ln -s /user-files/.cloudstorage/cloud-storage/accounts/onedrive /user-files/OneDrive\n\
  mv /var/www/html/index.php /var/www/html/index-original.php\n\
  echo -e \"<?php \\\n session_name('FileRunSID'); session_start(); \\\$username = 'superuser'; \\\$_SESSION['FileRun']['username'] = \\\$username; include 'index-original.php'; \\\n ?>\" > /var/www/html/index.php\n\
  exec \"\$@\"" > /entrypoint.sh

# Disable forced password reset
RUN sed -Ei 's;/wait;sed -Ei "s/require_password_change\\` = 1/require_password_change\\` = 0/" /filerun.setup.sql\; /wait;' /entrypoint.sh
