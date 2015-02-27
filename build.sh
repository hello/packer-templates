#!/bin/sh


while true
do
  read -p "$(echo 'Which app do you want to build? \n [1] suripu-app \n [2] suripu-service \n\n > ')" RESP
  case $RESP in
    [1])
      APP="suripu-app"
      echo "Building suripu-app"
      break
      ;;
    [2])
      APP="suripu-service"
      echo "Building suripu-service"
      break
      ;;
    *)
      echo "Please enter 1 or 2"
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


read -p "$(echo 'Specify ami-id \n > ')" AMI

if [ $APP == "suripu-app" ]
then
  SG="sg-d28624b6"
else
  SG="sg-11ac0e75"
fi

echo $APP
echo $SG

aws autoscaling create-launch-configuration \
--launch-configuration-name $APP-prod-$VERSION \
--image-id $AMI \
--key-name vpc-prod \
--security-groups $SG \
--instance-type m3.medium \
--instance-monitoring Enabled=true \
--iam-instance-profile suripu-app \
--associate-public-ip-address


echo "Launch configuration created for $APP and $VERSION"
