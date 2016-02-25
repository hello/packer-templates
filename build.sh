#!/bin/sh

while true
do
  read -p "$(echo 'Which app do you want to build? \n [1] suripu-app \n [2] suripu-queue \n\n > ')" RESP
  case $RESP in
    [1])
      APP="suripu-app"
      echo "Building suripu-app"
      break
      ;;
    [2])
      APP="suripu-queue"
      echo "Building suripu-queue"
      break
      ;;
    *)
      echo "Please enter 1 or 2:"
  esac
done



read -p "$(echo 'Which version do you want to build?\n> ')" VERSION

echo "Summary: $APP\n"
echo "\tapp: $APP\n"
echo "\tversion: $VERSION\n"

packer build \
 -var 'aws_access_key=AKIAII76K2Z5IMMJYEIA' \
 -var 'aws_secret_key=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' \
 -var "app_name=$APP" \
 -var "app_version=$VERSION" \
 suripu.json
