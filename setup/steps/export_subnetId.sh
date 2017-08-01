#!/bin/bash

subnetName="$name-subnet"

result=$(aws ec2 describe-subnets --profile $profileName --filters "Name=tag-value,Values=$subnetName")
if [[ $result == *"SubnetId"* ]]; then
    echo "Parsing existing subnet id..."
    export subnetId=$(echo $result | python -c "import sys, json; result = json.loads(sys.stdin.read()); print(result['Subnets'][0]['SubnetId'])")
else
    echo "Creating a subnet Id..."
    export subnetId=$(aws ec2 create-subnet --vpc-id $vpcId --cidr-block 10.0.0.0/28 --query 'Subnet.SubnetId' --output text --profile $profileName)
    aws ec2 create-tags --resources $subnetId --tags --tags Key=Name,Value=$subnetName --profile $profileName
fi

echo "Your subnet id is: $subnetId"
