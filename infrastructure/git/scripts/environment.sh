GIT_EMAIL=$(git config --get user.email)
GIT_NAME=$(git config --get user.name)

echo export GIT_AUTHOR_EMAIL=${GIT_AUTHOR_EMAIL-$GIT_EMAIL}
echo export GIT_AUTHOR_NAME=${GIT_AUTHOR_NAME-$GIT_NAME}
echo export CLOUD_COMPUTER_GIT_BRANCH=$(git branch --contains HEAD | cut -c 3-)
echo export CLOUD_COMPUTER_GIT_URL=$(git config --get remote.origin.url)
