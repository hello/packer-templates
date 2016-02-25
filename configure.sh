#!/bin/sh

sleep 10
sudo apt-get update
#sudo apt-get upgrade
sudo apt-get install -y htop
sudo apt-get install -y openjdk-7-jre
sudo apt-get install -y ntp
# sudo apt-get install -y nginx

PKG_NAME=${APP_NAME}_${APP_VERSION}_amd64.deb
aws s3 cp s3://hello-deploy/pkg/${APP_NAME}/$PKG_NAME /tmp/
sudo dpkg -i /tmp/$PKG_NAME


aws s3 cp s3://hello-deploy/pkg/kenko/kenko_latest_amd64.deb /tmp/
sudo dpkg -i /tmp/kenko_latest_amd64.deb

# papertrail support only for workers now
aws s3 cp s3://hello-deploy/pkg/papertrail/papertrail_1.1_amd64.deb /tmp/
sudo dpkg -i /tmp/papertrail_1.1_amd64.deb

