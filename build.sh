#!/bin/sh


while true
do
  read -p "$(echo 'Which app do you want to build? \n [1] suripu-app \n [2] suripu-service \n [3] suripu-workers \n\n > ')" RESP
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
    [3])
      APP="suripu-workers"
      echo "Building suripu-workers"
      break
      ;;
    *)
      echo "Please enter 1, 2 or 3"
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

INSTANCE_TYPE="m3.medium"

if [ $APP == "suripu-app" ];
then
  SG="sg-d28624b6"
elif [ $APP == "suripu-workers" ];
then
  SG="sg-7054d714"
  INSTANCE_TYPE="c3.xlarge"
else
  SG="sg-11ac0e75"
fi

echo $APP
echo $SG
echo $INSTANCE_TYPE

aws autoscaling create-launch-configuration \
--launch-configuration-name $APP-prod-$VERSION \
--image-id $AMI \
--key-name vpc-prod \
--security-groups $SG \
--instance-type $INSTANCE_TYPE \
--instance-monitoring Enabled=true \
--iam-instance-profile $APP \
--associate-public-ip-address


echo "Launch configuration created for $APP and $VERSION"
