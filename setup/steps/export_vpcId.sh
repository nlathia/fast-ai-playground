#!/bin/bash

export vpcId=$(aws ec2 describe-vpcs --profile $profileName --filters "Name=tag-value,Values=$name" --query "Vpcs[0].VpcId" --output text)

if [ "$vpcId" = "None" ]
  then
    echo "Creating a VPC..."
    export vpcId=$(aws ec2 create-vpc --cidr-block 10.0.0.0/28 --query 'Vpc.VpcId' --output text --profile $profileName)
    aws ec2 create-tags --resources $vpcId --tags Key=Name,Value=$name --profile $profileName
    aws ec2 modify-vpc-attribute --vpc-id $vpcId --enable-dns-support "{\"Value\":true}" --profile $profileName
    aws ec2 modify-vpc-attribute --vpc-id $vpcId --enable-dns-hostnames "{\"Value\":true}" --profile $profileName
fi

echo "Your VPC id is: $vpcId"
