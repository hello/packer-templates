#!/bin/sh

APP="taimurain-2"
echo "Building Taimurain"

read -p "$(echo 'Which version do you want to build?\n> ')" VERSION

echo "Summary: $APP\n"
echo "\tapp: $APP\n"
echo "\tversion: $VERSION\n"

packer build \
 -var 'aws_access_key=AKIAII76K2Z5IMMJYEIA' \
 -var 'aws_secret_key=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' \
 -var "app_name=$APP" \
 -var "app_version=$VERSION" \
 taimurain.json


# -var 'aws_access_key=AKIAII76K2Z5IMMJYEIA' \
# -var 'aws_secret_key=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' \

# -var 'aws_access_key=AKIAJ7KQ4RGS4P55NSVQ' \
# -var 'aws_secret_key=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' \
