#!/bin/sh
# Get the instance region and inject it in the conf
REGION=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone | sed 's/.\{1\}$//')
sed -i -e 's/.*region.*/region = '$REGION'/' /var/awslogs/etc/aws.conf

# Restart the awslogs agent
service awslogs restart