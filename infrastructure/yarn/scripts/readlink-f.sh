# Platform independent readlink functionality from https://stackoverflow.com/questions/1055671/how-can-i-get-the-behavior-of-gnus-readlink-f-on-a-mac
SYMLINK_PATH=$1

# Initialize the working directory to the symlink directory
cd $(dirname $SYMLINK_PATH)

# The pointer for navigating the directory tree
FILE_POINTER=$(basename $SYMLINK_PATH)

# Iterate down a (possible) chain of symlinks
while [ -L "$FILE_POINTER" ]; do
  FILE_POINTER=$(readlink $FILE_POINTER)
  cd $(dirname $FILE_POINTER)
  FILE_POINTER=$(basename $FILE_POINTER)
done

# Compute the canonicalized name from the final directory and the symlink target name
TARGET_DIRECTORY=$(pwd -P)
SYMLINK_TARGET=$TARGET_DIRECTORY/$FILE_POINTER

echo $SYMLINK_TARGET
