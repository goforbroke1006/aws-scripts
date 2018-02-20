#!/usr/bin/env bash

echo 'Enter project name: '
read projectName

aws iam create-role \
    --role-name ${projectName}-Role \
    --assume-role-policy-document file://CodeDeploy-Trust.json

aws iam attach-role-policy \
    --role-name ${projectName}-Role \
    --policy-arn arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole

aws iam get-role \
    --role-name ${projectName}-Role \
    --query "Role.Arn" \
    --output text