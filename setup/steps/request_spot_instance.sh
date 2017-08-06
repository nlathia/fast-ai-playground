#!/bin/bash

instanceName="$name-spot-gpu-machine"
# See spot instance pricing history here:
# http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-spot-instances-history.html
bidPrice=0.25

cat >specs.json <<EOF
{
  "ImageId" : "$ami",
  "InstanceType": "$instanceType",
  "KeyName" : "aws-key-$name",
  "EbsOptimized": true,
  "BlockDeviceMappings": [
    {
      "DeviceName": "/dev/sda1",
      "Ebs": {
        "DeleteOnTermination": true,
        "VolumeType": "gp2",
        "VolumeSize": 128
      }
    }
  ],
  "NetworkInterfaces": [
      {
        "DeviceIndex": 0,
        "SubnetId": "${subnetId}",
        "Groups": [ "${securityGroupId}" ],
        "AssociatePublicIpAddress": true
      }
  ]
}
EOF

# Get the first available zone
# TODO: get the available zone with the cheapest spot price
# https://gist.github.com/pahud/fbbc1fd80fac4544fd0a3a480602404e
zone=$(aws ec2 describe-availability-zones --profile $profileName --output text --query "AvailabilityZones[0].ZoneName")

echo "Requesting a spot instance in $zone"
requestId=$(aws ec2 request-spot-instances --spot-price $bidPrice --instance-count 1 --type "one-time" --launch-specification file://specs.json --profile $profileName --output text --query="SpotInstanceRequests[*].SpotInstanceRequestId" --availability-zone-group $zone)

rm specs.json  # Clean up

echo "Spot instance request id is: $requestId. Waiting for request to be fulfilled..."
sleep 5
aws ec2 wait spot-instance-request-fulfilled --spot-instance-request-ids $requestId --profile $profileName

export instanceId=$(aws ec2 describe-spot-instance-requests --spot-instance-request-ids $requestId --query="SpotInstanceRequests[*].InstanceId" --output="text" --profile $profileName)

aws ec2 create-tags --resources $instanceId --tags --tags Key=Name,Value=$instanceName --profile $profileName
export allocAddr=$(aws ec2 allocate-address --domain vpc --query 'AllocationId' --output text --profile $profileName)

echo "Waiting for instance start..."
aws ec2 wait instance-running --instance-ids $instanceId --profile $profileName
sleep 10 # wait for ssh service to start running too

export assocId=$(aws ec2 associate-address --instance-id $instanceId --allocation-id $allocAddr --query 'AssociationId' --output text --profile $profileName)
export instanceUrl=$(aws ec2 describe-instances --instance-ids $instanceId --query 'Reservations[0].Instances[0].PublicDnsName' --output text --profile $profileName)

echo "Your instance id is: $instanceId"
echo "The address id is: $assocId"
echo "The instance URL is: $instanceUrl"
