#!/bin/bash

## save delete commands for cleanup
target=uninstall-$instanceType.sh

echo Creating $target...

echo "#!/bin/bash" > $target # overwrite existing file
echo ". $(dirname "$0")/$name-variables.sh" >> $target

echo aws ec2 disassociate-address --association-id $assocId --profile $profileName >> $target
echo aws ec2 release-address --allocation-id $allocAddr --profile $profileName >> $target

## volume gets deleted with the instance automatically
echo aws ec2 terminate-instances --instance-ids $instanceId --profile $profileName >> $target
echo aws ec2 wait instance-terminated --instance-ids $instanceId --profile $profileName >> $target
echo aws ec2 delete-security-group --group-id $securityGroupId --profile $profileName >> $target

echo aws ec2 disassociate-route-table --association-id $routeTableAssoc --profile $profileName >> $target
echo aws ec2 delete-route-table --route-table-id $routeTableId --profile $profileName >> $target

echo aws ec2 detach-internet-gateway --internet-gateway-id $internetGatewayId --vpc-id $vpcId --profile $profileName >> $target
echo aws ec2 delete-internet-gateway --internet-gateway-id $internetGatewayId --profile $profileName >> $target
echo aws ec2 delete-subnet --subnet-id $subnetId --profile $profileName >> $target
echo rm $name-*.sh >> $target

echo aws ec2 delete-vpc --vpc-id $vpcId --profile $profileName >> $target
echo echo If you want to delete the key-pair, please do it manually. >> $target

chmod u+x $target
