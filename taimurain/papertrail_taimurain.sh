#!/bin/sh -x


VERSION=1.3

TEMP_DIR="/tmp/papertrail-app"
mkdir -p $TEMP_DIR/opt/papertrail
mkdir -p $TEMP_DIR/etc/papertrail
mkdir -p $TEMP_DIR/etc/init/

wget --directory-prefix /tmp/ https://github.com/papertrail/remote_syslog2/releases/download/v0.17/remote_syslog_linux_amd64.tar.gz
tar -xf /tmp/remote_syslog_linux_amd64.tar.gz -C /tmp/
mv /tmp/remote_syslog/* $TEMP_DIR/opt/papertrail/

tee $TEMP_DIR/etc/init/papertrail.conf << EOF
description "Monitor files and send to remote syslog"
start on runlevel [2345]
stop on runlevel [!2345]

respawn

pre-start exec /usr/bin/test -e /etc/papertrail/taimurain_logs.yml

exec /opt/papertrail/remote_syslog -D  -c /etc/papertrail/taimurain_logs.yml >> /var/log/papertrail.log 2>&1
EOF

fpm --force -s dir -C $TEMP_DIR -t deb --name "papertrail_taimurain" --version $VERSION --config-files etc/papertrail .

aws s3 cp papertrail*.deb s3://hello-deploy/pkg/papertrail/
# rm -rf $TEMP_DIR
# rm *.deb
