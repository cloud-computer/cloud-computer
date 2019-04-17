MSG="\033[36;4m"
ESC="\e[0m"
BASE="https://github.com/cloud-computer/cloud-computer/commit/"

CURRENT_COMMIT=$(git rev-parse --verify HEAD)
URL=$BASE$CURRENT_COMMIT

echo "The newly pushed commit(s) can be accessed at: \n$MSG$URL$ESC";
echo
