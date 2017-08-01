#!/bin/bash

subnetName="$name-subnet"

export subnetId=$(aws ec2 describe-subnets --profile $profileName --filters "Name=tag-value,Values=$subnetName" --query "Subnets[0].SubnetId" --output text)

if [ "$subnetId" = "None" ]
  then
    echo "Creating a subnet Id..."
    export subnetId=$(aws ec2 create-subnet --vpc-id $vpcId --cidr-block 10.0.0.0/28 --query 'Subnet.SubnetId' --output text --profile $profileName)
    aws ec2 create-tags --resources $subnetId --tags --tags Key=Name,Value=$subnetName --profile $profileName
fi

echo "Your subnet id is: $subnetId"
