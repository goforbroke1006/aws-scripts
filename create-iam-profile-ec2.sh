#!/usr/bin/env bash

echo 'Enter project name: '
read projectName

aws iam create-role \
    --role-name ${projectName}-EC2-Instance-Profile \
    --assume-role-policy-document file://EC2-Trust.json

aws iam put-role-policy \
    --role-name ${projectName}-EC2-Instance-Profile \
    --policy-name ${projectName}-EC2-Permissions \
    --policy-document file://EC2-Permissions.json

aws iam create-instance-profile \
    --instance-profile-name ${projectName}-EC2-Instance-Profile

aws iam add-role-to-instance-profile \
    --instance-profile-name ${projectName}-EC2-Instance-Profile \
    --role-name ${projectName}-EC2-Instance-Profile

