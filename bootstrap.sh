#!/bin/sh

sleep 10
sudo apt-get update
export DEBIAN_FRONTEND=noninteractive
sudo apt-get upgrade -o Dpkg::Options::=--force-confdef -y
sudo apt-get install -y htop
sudo apt-get install -y openjdk-7-jre
sudo apt-get install -y ntp
# sudo apt-get install -y nginx




# s3cmd get s3://hello-deploy/configs/com/hello/suripu/suripu-app/$VERSION/suripu-app.prod.yml . --force
# s3cmd get s3://hello-deploy/configs/com/hello/suripu/suripu-service/$VERSION/suripu-service.prod.yml . --force
# s3cmd get s3://hello-deploy/configs/com/hello/suripu/suripu-workers/$VERSION/pillscorer.prod.yml . --force
# s3cmd get s3://hello-deploy/configs/com/hello/suripu/suripu-workers/$VERSION/pill.prod.yml . --force
# s3cmd get s3://hello-deploy/configs/com/hello/suripu/suripu-workers/$VERSION/alarm_worker.prod.yml . --force
# s3cmd get s3://hello-deploy/configs/com/hello/suripu/suripu-workers/$VERSION/sense_save.prod.yml . --force
# s3cmd get s3://hello-deploy/configs/com/hello/suripu/suripu-workers/$VERSION/index_logs_worker.prod.yml . --force
# s3cmd get s3://hello-deploy/configs/com/hello/suripu/suripu-workers/$VERSION/insights_generator.prod.yml . --force
# s3cmd get s3://hello-deploy/configs/com/hello/suripu/suripu-workers/$VERSION/timeline_worker.prod.yml . --force
# s3cmd get s3://hello-deploy/configs/com/hello/suripu/suripu-workers/$VERSION/push-notifications.prod.yml . --force

# s3cmd get s3://hello-maven/release/com/hello/suripu/suripu-app/$VERSION/suripu-app-$VERSION.jar . --force
# s3cmd get s3://hello-maven/release/com/hello/suripu/suripu-service/$VERSION/suripu-service-$VERSION.jar . --force
# s3cmd get s3://hello-maven/release/com/hello/suripu/suripu-workers/$VERSION/suripu-workers-$VERSION.jar . --force
