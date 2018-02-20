// TODO: SH header needs

aws iam create-role \
    --role-name CodeDeployServiceRole 
	--assume-role-policy-document file://CodeDeployAll-Trust.json
aws iam attach-role-policy --role-name CodeDeployServiceRole \
    --policy-arn arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole

serviceRoleARN=$(aws iam get-role --role-name CodeDeployServiceRole --query "Role.Arn" --output text)

echo 'Enter application name (without spaces, only a-z A-Z 0-9), for example "CodeDeployGitHubDemo": '
read applicationBaseName

aws deploy create-application --application-name ${applicationBaseName}-App

aws deploy create-deployment-group \
    --application-name ${applicationBaseName}-App \
	--ec2-tag-filters Key=ec2-tag-key,Type=KEY_AND_VALUE,Value=ec2-tag-value \
#	--on-premisestag-filters Key=on-premises-tag-key,Type=KEY_AND_VALUE,Value=on-premises-tag-value \
	--deployment-group-name ${applicationBaseName}-DepGrp \
	--service-role-arn ${serviceRoleARN}

echo 'Enter GitHub "userName/projectName": '
read repository

echo 'Enter commit hash: '
read commitId

aws deploy create-deployment \
    --application-name ${applicationBaseName}-App \
    --deployment-config-name CodeDeployDefault.OneAtATime \
    --deployment-group-name ${applicationBaseName}-DepGrp \
    --description "My GitHub deployment demo" \
    --github-location repository=${repository},commitId=${commitId}

aws deploy list-deployments \
    --application-name ${applicationBaseName}-App 
	--deploymentgroup-name ${applicationBaseName}-DepGrp \
	--query "deployments" \
	--output text

echo 'Enter deployment ID: '
read deploymentId

aws deploy get-deployment \
    --deployment-id ${deploymentId} \
	--query "deploymentInfo.[status, creator]" \
	--output text
