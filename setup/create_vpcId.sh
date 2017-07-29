#!/bin/bash

if [ -z "$profileName" ]; then
    echo "Missing \$profileName; this script should be called from"
    echo "setup_t2.sh or setup_p2.sh!"
    exit 1
fi

export result=$(aws ec2 describe-vpcs --profile $profileName --filters 'Name=cidr,Values=10.0.0.0/28')
if [[ $result == *"VpcId"* ]]; then
    echo 'Parsing: vpcId...'
    export vpcId=$(echo $result | python -c "import sys, json; result = json.loads(sys.stdin.read()); print(result['Vpcs'][0]['VpcId'])")
else
    echo 'Creating: vpcId...'
    export vpcId=$(aws ec2 create-vpc --cidr-block 10.0.0.0/28 --query 'Vpc.VpcId' --output text --profile $profileName)
    aws ec2 create-tags --resources $vpcId --tags --tags Key=Name,Value=$name --profile $profileName
    aws ec2 modify-vpc-attribute --vpc-id $vpcId --enable-dns-support "{\"Value\":true}" --profile $profileName
    aws ec2 modify-vpc-attribute --vpc-id $vpcId --enable-dns-hostnames "{\"Value\":true}" --profile $profileName
fi
echo "VpcId = $vpcId"