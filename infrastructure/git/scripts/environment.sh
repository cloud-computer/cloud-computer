GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
GIT_EMAIL=$(git config --get user.email)
GIT_NAME=$(git config --get user.name)
GIT_URL=$(git config --get remote.origin.url)

echo export GIT_AUTHOR_EMAIL=${GIT_AUTHOR_EMAIL-$GIT_EMAIL}
echo export GIT_AUTHOR_NAME=${GIT_AUTHOR_NAME-$GIT_NAME}
echo export CLOUD_COMPUTER_GIT_BRANCH=${CLOUD_COMPUTER_GIT_BRANCH-$GIT_BRANCH}
echo export CLOUD_COMPUTER_GIT_URL=${CLOUD_COMPUTER_GIT_URL-$GIT_URL}
