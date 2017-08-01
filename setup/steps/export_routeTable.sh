#!/bin/bash

routeTableName="$name-route-table"

export routeTableId=$(aws ec2 describe-route-tables --profile $profileName --filters "Name=tag-value,Values=$routeTableName" --query "RouteTables[0].RouteTableId" --output text)

if [ "$routeTableId" = "None" ]
  then
    echo "Creating a new route table..."
    export routeTableId=$(aws ec2 create-route-table --vpc-id $vpcId --query 'RouteTable.RouteTableId' --output text --profile $profileName)
    aws ec2 create-tags --resources $routeTableId --tags --tags Key=Name,Value=$routeTableName --profile $profileName
    export routeTableAssoc=$(aws ec2 associate-route-table --route-table-id $routeTableId --subnet-id $subnetId --output text --profile $profileName)
    aws ec2 create-route --route-table-id $routeTableId --destination-cidr-block 0.0.0.0/0 --gateway-id $internetGatewayId --profile $profileName
fi

echo "Your route table id is: $routeTableId"
