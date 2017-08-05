#!/bin/bash

volumeId=$(aws ec2 describe-volumes --profile $profileName --filters "Name=attachment.instance-id,Values=$instanceId" --query "Volumes[0].VolumeId" --output text)

aws ec2 stop-instances --instance-ids $instanceId --profile $profileName
aws ec2 wait instance-stopped --instance-ids $instanceId --profile $profileName

if [ "$volumeId" != "None" ]
  then
    devicePath=$(aws ec2 describe-volumes --profile $profileName --filters "Name=attachment.instance-id,Values=$instanceId" --query "Volumes[0].Attachments[0].Device" --output text)
    snapshotId=$(aws ec2 create-snapshot --volume-id $volumeId --profile $profileName --query "SnapshotId" --output text)

    aws ec2 detach-volume --volume-id $volumeId --profile $profileName
    aws ec2 delete-volume --volume-id $volumeId --profile $profileName
    echo export snapshotId=$snapshotId > $name-snapshot.sh
    echo export instanceId=$instanceId >> $name-snapshot.sh
    echo export devicePath=$devicePath >> $name-snapshot.sh
    echo "Storing snapshot id: $snapshotId"
    chmod u+x $name-snapshot.sh
else
  echo 'No volumes attached to instance.'
fi
