#!/bin/bash
gatewayName="$name-gateway"

result=$(aws ec2 describe-internet-gateways --profile $profileName --filters "Name=tag-value,Values=$gatewayName")
if [[ $result == *"InternetGatewayId"* ]]; then
    echo "Parsing existing Internet Gateway id..."
    export internetGatewayId=$(echo $result | python -c "import sys, json; result = json.loads(sys.stdin.read()); print(result['InternetGateways'][0]['InternetGatewayId'])")
else
    echo "Creating a new Internet Gateway..."
    export internetGatewayId=$(aws ec2 create-internet-gateway --query 'InternetGateway.InternetGatewayId' --output text --profile $profileName)
    aws ec2 create-tags --resources $internetGatewayId --tags Key=Name,Value=$gatewayName --profile $profileName
fi

echo "Your Internet Gateway id is: $internetGatewayId"

result=$(aws ec2 describe-internet-gateways --profile $profileName --filters "Name=tag-value,Values=$gatewayName" "Name=attachment.state,Values=available")
attachedState=$(echo $result | python -c "import sys, json; result = json.loads(sys.stdin.read()); print(len(result['InternetGateways']))")

if [[ $attachedState -eq 0 ]]
  then
    echo "Attaching Internet Gateway to VPC..."
    aws ec2 attach-internet-gateway --internet-gateway-id $internetGatewayId --vpc-id $vpcId --profile $profileName
else
  echo "Gateway already attached..."
fi
