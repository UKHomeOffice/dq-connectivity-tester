#!/bin/sh
INSTANCE_ID=$(ec2metadata --instance-id)
FAILURES=$(curl -s localhost:8080 | grep -c fail)
SUCCESSES=$(curl -s localhost:8080 | grep -c true)
CHECKS=$(curl -s localhost:8080 | grep -c "Connect to")

REGION=$(ec2metadata --availability-zone | head -c-2)

aws --region=${REGION} cloudwatch put-metric-data --metric-name ConnectivityTesterFailures --namespace ConnectivityTester --value ${FAILURES} --dimensions InstanceId=${INSTANCE_ID}
aws --region=${REGION} cloudwatch put-metric-data --metric-name ConnectivityTesterSuccesses --namespace ConnectivityTester --value ${SUCCESSES} --dimensions InstanceId=${INSTANCE_ID}
aws --region=${REGION} cloudwatch put-metric-data --metric-name ConnectivityTesterChecks --namespace ConnectivityTester --value ${CHECKS} --dimensions InstanceId=${INSTANCE_ID}

