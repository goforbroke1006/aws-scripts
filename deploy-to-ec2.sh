#!/usr/bin/env bash

echo 'Enter project name: '
read projectName

echo 'Repository (userOrOrganizationName/projectName): '
read repository

echo 'Commit ID: '
read commitId

aws deploy create-deployment \
    --application-name ${projectName}-App \
    --deployment-config-name CodeDeployDefault.OneAtATime \
    --deployment-group-name ${projectName}-DepGrp \
    --description "My GitHub deployment demo" \
    --github-location repository=${repository},commitId=${commitId}

sleep 10

aws deploy list-deployments \
    --application-name ${projectName}-App \
    --deployment-group-name ${projectName}-DepGrp \
    --query "deployments" \
    --output text