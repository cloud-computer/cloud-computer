# Pick docker target in order of availability:
# 1. Cloud Computer
# 2. Local Machine

if [ ! -z "$TERRAFORM_TARGET" ]; then
  echo $TERRAFORM_TARGET
elif [ ! -z "$(TERRAFORM_TARGET=cloud-computer yarn --cwd ../terraform ip)" ]; then
  echo "cloud-computer"
else
  echo "localhost"
fi
