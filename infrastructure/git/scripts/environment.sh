GIT_EMAIL=$(git config --get user.email)
GIT_NAME=$(git config --get user.name)

echo export GIT_AUTHOR_EMAIL=$GIT_EMAIL
echo export GIT_AUTHOR_NAME=$GIT_NAME
echo export GIT_COMMITTER_EMAIL=$GIT_EMAIL
echo export GIT_COMMITTER_NAME=$GIT_NAME
