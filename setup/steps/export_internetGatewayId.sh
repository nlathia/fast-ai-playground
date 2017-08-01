#!/bin/bash
gatewayName="$name-gateway"

export internetGatewayId=$(aws ec2 describe-internet-gateways --profile $profileName --filters "Name=tag-value,Values=$gatewayName" --query "InternetGateways[0].InternetGatewayId" --output text)

if [ "$internetGatewayId" = "None" ]
  then
    echo "Creating a new Internet Gateway..."
    export internetGatewayId=$(aws ec2 create-internet-gateway --query 'InternetGateway.InternetGatewayId' --output text --profile $profileName)
    aws ec2 create-tags --resources $internetGatewayId --tags Key=Name,Value=$gatewayName --profile $profileName
fi

echo "Your Internet Gateway id is: $internetGatewayId"

attachedState=$(aws ec2 describe-internet-gateways --profile $profileName --filters "Name=tag-value,Values=$gatewayName" "Name=attachment.state,Values=available" --query "InternetGateways[0].Attachments[0].State" --output text)

if [ "$attachedState" = "available" ]
  then
    echo "Gateway already attached..."
else
  echo "Attaching Internet Gateway to VPC..."
  aws ec2 attach-internet-gateway --internet-gateway-id $internetGatewayId --vpc-id $vpcId --profile $profileName
fi
