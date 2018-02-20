#!/usr/bin/env bash

echo 'Enter project name: '
read projectName

aws deploy create-application \
    --application-name ${projectName}-App

serviceRoleARN=$(aws iam get-role --role-name ${projectName}-Role --query "Role.Arn" --output text)
echo "ARN=${serviceRoleARN}"

echo 'Enter EC2 tag key:'
read tagKey

echo 'Enter EC2 tag value:'
read tagVal

aws deploy create-deployment-group \
    --application-name ${projectName}-App \
    --ec2-tag-filters Key=${tagKey},Type=KEY_AND_VALUE,Value=${tagVal} \
    --deployment-group-name ${projectName}-DepGrp \
    --service-role-arn ${serviceRoleARN}