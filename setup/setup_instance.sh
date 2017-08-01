#!/bin/bash
#
# This script should be invoked via setup_t2.sh or setup_p2.sh; those scripts
# will export the right environment variables for this to succeed.





#export instanceId=$(aws ec2 run-instances --image-id $ami --count 1 --instance-type $instanceType --key-name aws-key-$name --security-group-ids $securityGroupId --subnet-id $subnetId --associate-public-ip-address --block-device-mapping "[ { \"DeviceName\": \"/dev/sda1\", \"Ebs\": { \"VolumeSize\": 128, \"VolumeType\": \"gp2\" } } ]" --query 'Instances[0].InstanceId' --output text --profile $profileName)
#aws ec2 create-tags --resources $instanceId --tags --tags Key=Name,Value=$name-gpu-machine --profile $profileName
#export allocAddr=$(aws ec2 allocate-address --domain vpc --query 'AllocationId' --output text --profile $profileName)

#echo Waiting for instance start...
#aws ec2 wait instance-running --instance-ids $instanceId --profile $profileName

#sleep 10 # wait for ssh service to start running too

#export assocId=$(aws ec2 associate-address --instance-id $instanceId --allocation-id $allocAddr --query 'AssociationId' --output text)
##export instanceUrl=$(aws ec2 describe-instances --instance-ids $instanceId --query 'Reservations[0].Instances[0].PublicDnsName' --output text --profile $profileName)

## reboot instance, because I was getting "Failed to initialize NVML: Driver/library version mismatch"
## error when running the nvidia-smi command
## see also http://forums.fast.ai/t/no-cuda-capable-device-is-detected/168/13
#aws ec2 reboot-instances --instance-ids $instanceId --profile $profileName

## save commands to file
#echo \# Connect to your instance: > $name-commands.txt # overwrite existing file
#echo ssh -i ~/.ssh/aws-key-$name.pem ubuntu@$instanceUrl >> $name-commands.txt

#echo \# Stop your instance: : >> $name-commands.txt
#echo aws ec2 stop-instances --instance-ids $instanceId --profile $profileName  >> $name-commands.txt

#echo \# Start your instance: >> $name-commands.txt
#echo aws ec2 start-instances --instance-ids $instanceId --profile $profileName  >> $name-commands.txt

#echo \# Reboot your instance: >> $name-commands.txt
#echo aws ec2 reboot-instances --instance-ids $instanceId --profile $profileName  >> $name-commands.txt
#echo ""

## export vars to be sure
#echo export instanceId=$instanceId >> $name-commands.txt
#echo export subnetId=$subnetId >> $name-commands.txt
#echo export securityGroupId=$securityGroupId >> $name-commands.txt
#echo export instanceUrl=$instanceUrl >> $name-commands.txt
#echo export routeTableId=$routeTableId >> $name-commands.txt
#echo export name=$name >> $name-commands.txt
#echo export vpcId=$vpcId >> $name-commands.txt
#echo export internetGatewayId=$internetGatewayId >> $name-commands.txt
#echo export subnetId=$subnetId >> $name-commands.txt
#echo export allocAddr=$allocAddr >> $name-commands.txt
#echo export assocId=$assocId >> $name-commands.txt
#echo export routeTableAssoc=$routeTableAssoc >> $name-commands.txt

## save delete commands for cleanup
#echo "#!/bin/bash" > $name-remove.sh # overwrite existing file
#echo aws ec2 disassociate-address --association-id $assocId --profile $profileName >> $name-remove.sh
#echo aws ec2 release-address --allocation-id $allocAddr --profile $profileName >> $name-remove.sh

## volume gets deleted with the instance automatically
#echo aws ec2 terminate-instances --instance-ids $instanceId --profile $profileName >> $name-remove.sh
#echo aws ec2 wait instance-terminated --instance-ids $instanceId --profile $profileName >> $name-remove.sh
#echo aws ec2 delete-security-group --group-id $securityGroupId --profile $profileName >> $name-remove.sh

#echo aws ec2 disassociate-route-table --association-id $routeTableAssoc --profile $profileName >> $name-remove.sh
#echo aws ec2 delete-route-table --route-table-id $routeTableId --profile $profileName >> $name-remove.sh

#echo aws ec2 detach-internet-gateway --internet-gateway-id $internetGatewayId --vpc-id $vpcId --profile $profileName >> $name-remove.sh
#echo aws ec2 delete-internet-gateway --internet-gateway-id $internetGatewayId --profile $profileName >> $name-remove.sh
#echo aws ec2 delete-subnet --subnet-id $subnetId --profile $profileName >> $name-remove.sh

#echo aws ec2 delete-vpc --vpc-id $vpcId --profile $profileName >> $name-remove.sh
#echo echo If you want to delete the key-pair, please do it manually. >> $name-remove.sh

#chmod +x $name-remove.sh

#echo All done. Find all you need to connect in the $name-commands.txt file and to remove the stack call $name-remove.sh
#echo Connect to your instance: ssh -i ~/.ssh/aws-key-$name.pem ubuntu@$instanceUrl
