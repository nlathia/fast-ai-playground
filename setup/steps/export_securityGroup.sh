#!/bin/bash

groupName="$name-security-group"
groupDescription="SG for $name"

export securityGroupId=$(aws ec2 describe-security-groups --profile $profileName --filters "Name=description,Values=$groupDescription" --query "SecurityGroups[0].GroupId" --output text)

if [ "$securityGroupId" = "None" ]
  then
    echo "Creating a security group..."
    export securityGroupId=$(aws ec2 create-security-group --group-name "$groupName" --description "$groupDescription" --vpc-id $vpcId --query 'GroupId' --output text --profile $profileName)
    aws ec2 authorize-security-group-ingress --group-id $securityGroupId --protocol tcp --port 22 --cidr $cidr --profile $profileName
fi

echo "Your security group id is: $securityGroupId"
