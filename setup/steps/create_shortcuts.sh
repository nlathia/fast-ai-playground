#!/bin/bash

echo Creating shortcuts...
rm -f $name-*.sh

## export vars to be sure
echo \# Your setup variables: > $name-variables.sh
echo export instanceId=$instanceId >> $name-variables.sh
echo export subnetId=$subnetId >> $name-variables.sh
echo export securityGroupId=$securityGroupId >> $name-variables.sh
echo export instanceUrl=$instanceUrl >> $name-variables.sh
echo export routeTableId=$routeTableId >> $name-variables.sh
echo export name=$name >> $name-variables.sh
echo export assocId=$assocId >> $name-variables.sh
echo export vpcId=$vpcId >> $name-variables.sh
echo export internetGatewayId=$internetGatewayId >> $name-variables.sh
echo export subnetId=$subnetId >> $name-variables.sh
echo export routeTableAssoc=$routeTableAssoc >> $name-variables.sh
echo export profileName=$profileName >> $name-variables.sh
echo export allocAddr=$allocAddr >> $name-variables.sh
echo export routeTableAssoc=$routeTableAssoc >> $name-variables.sh

echo \# Connect to your instance: > $name-connect.sh
echo ssh -i ~/.ssh/aws-key-$name.pem ubuntu@$instanceUrl >> $name-connect.sh
chmod u+x $name-connect.sh

echo \# Stop your instance: > $name-stop.sh
echo volumeId=\$\(aws ec2 describe-volumes --profile $profileName --filters "Name=attachment.instance-id,Values=$instanceId" --query "Volumes[0].VolumeId" --output text\) >> $name-stop.sh
echo devicePath=\$\(aws ec2 describe-volumes --profile $profileName --filters "Name=attachment.instance-id,Values=$instanceId" --query "Volumes[0].Attachments[0].Device" --output text\) >> $name-stop.sh
echo snapshotId=\$\(aws ec2 create-snapshot --volume-id \$volumeId --profile $profileName --query "SnapshotId" --output text\) >> $name-stop.sh
echo aws ec2 detach-volume --volume-id \$volumeId --profile $profileName  >> $name-stop.sh
echo aws ec2 delete-volume --volume-id \$volumeId --profile $profileName >> $name-stop.sh
echo aws ec2 stop-instances --instance-ids $instanceId --profile $profileName >> $name-stop.sh
echo "echo export snapshotId=\$snapshotId > snapshot.sh" >> $name-stop.sh
chmod u+x $name-stop.sh

echo \# Start your instance: > $name-start.sh
echo "./snapshot.sh" >> $name-start.sh
echo zone=\$\(aws ec2 describe-instances --profile $profileName --filter "Name=tag-value,Values=fast-ai-gpu-machine" --query "Reservations[0].Instances[0].Placement.AvailabilityZone" --output text\) >> $name-start.sh
echo volumeId=\$\(aws ec2 create-volume --snapshot-id \$snapshotId --availability-zone \$zone --profile $profileName --query \"VolumeId\" --output text\) >> $name-start.sh
echo aws ec2 attach-volume --instance-id $instanceId --volume-id \$volumeId --device \$devicePath --profile $profileName >> $name-start.sh
echo aws ec2 start-instances --instance-ids $instanceId --profile $profileName  >> $name-start.sh
chmod u+x $name-start.sh

echo \# Reboot your instance: >> $name-reboot.sh
echo aws ec2 reboot-instances --instance-ids $instanceId --profile $profileName  >> $name-reboot.sh
chmod u+x $name-reboot.sh
