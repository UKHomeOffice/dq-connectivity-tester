#!/bin/bash
INSTANCE_ID=$(ec2metadata --instance-id)
FAILURES=$(curl -s localhost:8080 | grep -c false)
SUCCESSES=$(curl -s localhost:8080 | grep -c true)
CHECKS=$(curl -s localhost:8080 | grep -c "Connect to")
REGION=$(ec2metadata --availability-zone | head -c-2)

function get_tag {
    echo $(aws --region=$REGION ec2 describe-tags --filters "Name=resource-id,Values=${INSTANCE_ID}" "Name=key,Values=${1}") | python -c $'import json,sys;obj=json.load(sys.stdin);\nif len(obj["Tags"])>0:\n print obj["Tags"][0]["Value"]\nelse:\n print "unknown"'
}

DIMENSIONS=InstanceId=${INSTANCE_ID:-unknown},Service=$(get_tag Service),Environment=$(get_tag Environment),EnvironmentGroup=$(get_tag EnvironmentGroup)

aws --region=${REGION} cloudwatch put-metric-data --dimensions ${DIMENSIONS} --metric-name ConnectivityTesterFail --namespace ConnectivityTester --value ${FAILURES}
aws --region=${REGION} cloudwatch put-metric-data --dimensions ${DIMENSIONS} --metric-name ConnectivityTesterPass --namespace ConnectivityTester --value ${SUCCESSES}
aws --region=${REGION} cloudwatch put-metric-data --dimensions ${DIMENSIONS} --metric-name ConnectivityTesterTest --namespace ConnectivityTester --value ${CHECKS}

