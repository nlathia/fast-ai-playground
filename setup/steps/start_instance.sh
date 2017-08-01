#!/bin/bash

zone=$(aws ec2 describe-instances --profile $profileName --filter "Name=tag-value,Values=fast-ai-gpu-machine" --query "Reservations[0].Instances[0].Placement.AvailabilityZone" --output text)

if [ -e "snapshot.sh" ]
  then
    . $(dirname "$0")/snapshot.sh
    echo "Creating volume from snapshot: $snapshotId"
    volumeId=$(aws ec2 create-volume --snapshot-id $snapshotId --availability-zone $zone --profile $profileName --query "VolumeId" --output text)

else
  echo 'No snapshots, creating a new volume...'
  volumeId=$(aws ec2 create-volume --availability-zone $zone --volume-type gp2 --size 128 --profile $profileName --query "VolumeId" --output text)
  devicePath="/dev/sda1"
  aws ec2 wait volume-available --volume-ids $volumeId --profile $profileName
fi

echo "Starting up instance: $instanceId, with volume: $volumeId, device: $devicePath"
aws ec2 attach-volume --instance-id $instanceId --volume-id $volumeId --device $devicePath --profile $profileName
aws ec2 start-instances --instance-ids $instanceId --profile $profileName
