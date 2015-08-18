#!/bin/sh -x


VERSION=1.1

TEMP_DIR="/tmp/papertrail-app"
mkdir -p $TEMP_DIR/opt/papertrail
mkdir -p $TEMP_DIR/etc/papertrail
mkdir -p $TEMP_DIR/etc/init/

#/home/travis/bin/aws s3 get s3://hello-deploy/configs/com/hello/suripu/suripu-app/$VERSION/suripu-app.prod.yml $TEMP_DIR/etc/hello --force
#/home/travis/bin/aws s3get s3://hello-maven/release/com/hello/suripu/suripu-app/$VERSION/suripu-app-$VERSION.jar $TEMP_DIR/opt/hello --force

wget --directory-prefix /tmp/ https://github.com/papertrail/remote_syslog2/releases/download/v0.13/remote_syslog_linux_amd64.tar.gz
tar -xf /tmp/remote_syslog_linux_amd64.tar.gz -C /tmp/
mv /tmp/remote_syslog/* $TEMP_DIR/opt/papertrail/

tee $TEMP_DIR/etc/init/papertrail.conf << EOF
description "Monitor files and send to remote syslog"
start on runlevel [2345]
stop on runlevel [!2345]

respawn

pre-start exec /usr/bin/test -e /etc/papertrail/log_files.yml

exec /opt/papertrail/remote_syslog -D  -c /etc/papertrail/log_files.yml >> /var/log/papertrail.log 2>&1
EOF

tee $TEMP_DIR/etc/papertrail/log_files.yml << EOF
files: 
  - /var/log/suripu-*/suripu-*.log
destination:
  host: logs2.papertrailapp.com
  port: 11366   # NOTE: change to your Papertrail port
  protocol: tls
EOF




fpm --force -s dir -C $TEMP_DIR -t deb --name "papertrail" --version $VERSION --config-files etc/papertrail .

s3cmd put papertrail*.deb s3://hello-deploy/pkg/papertrail/
rm -rf $TEMP_DIR
rm *.deb