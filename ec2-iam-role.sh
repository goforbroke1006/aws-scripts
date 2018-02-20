

aws iam create-role --role-name CodeDeployDemo-EC2-Instance-Profile --assume-rolepolicy-document
file://CodeDeployDemo-EC2-Trust.json

aws iam put-role-policy --role-name CodeDeployDemo-EC2-Instance-Profile --policyname
CodeDeployDemo-EC2-Permissions --policy-document file://CodeDeployDemo-EC2-
Permissions.json