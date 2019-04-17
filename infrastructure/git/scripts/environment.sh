GIT_EMAIL=$(git config --get user.email)
GIT_NAME=$(git config --get user.name)

echo GIT_AUTHOR_EMAIL=$GIT_EMAIL
echo GIT_AUTHOR_NAME=$GIT_NAME
echo GIT_COMMITTER_EMAIL=$GIT_EMAIL
echo GIT_COMMITTER_NAME=$GIT_NAME
