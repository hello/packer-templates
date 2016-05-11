#!/bin/sh

sleep 10
# sudo apt-get update
# #sudo apt-get upgrade
# sudo apt-get install -y htop
# sudo apt-get install -y ntp
# sudo apt-get install awscli

# APP_NAME="taimurain"
# APP_VERSION="0.1.12"

export AWS_SECRET_ACCESS_KEY=nctrKbHSwkfLcUMifmgl7Uh3HcU+Yuiz/ZmfQjm2
export AWS_ACCESS_KEY_ID=AKIAII76K2Z5IMMJYEIA

PKG_NAME=${APP_NAME}_${APP_VERSION}_amd64.deb
echo "Downloading $PKG_NAME"
aws s3 cp s3://hello-deploy/packages/com/hello/${APP_NAME}/${APP_VERSION}/$PKG_NAME /tmp/ --region us-east-1
sudo dpkg -i /tmp/$PKG_NAME

# papertrail support only for workers now
PAPERTRAIL_PACKAGE=papertrail-taimurain-16_1.4_amd64.deb
aws s3 cp s3://hello-deploy/pkg/papertrail/${PAPERTRAIL_PACKAGE} /tmp/ --region us-east-1
sudo dpkg -i /tmp/${PAPERTRAIL_PACKAGE}

# 

sudo mv /etc/nginx/sites-available/default /tmp/nginx_default

sudo touch /var/log/taimurain_uwsgi.log
sudo chown ubuntu:ubuntu /var/log/taimurain_uwsgi.log

sudo chown ubuntu:ubuntu /opt/hello

sudo nginx -t

