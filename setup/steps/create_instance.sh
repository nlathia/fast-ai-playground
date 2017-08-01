#!/bin/bash

instanceName="$name-gpu-machine"

export instanceId=$(aws ec2 describe-instances --profile $profileName --output text --query "Reservations[0].Instances[0].InstanceId" --filter "Name=tag-value,Values=$instanceName" "Name=instance-state-code,Values=0,16,32")

if [[ -z $instanceId ]]
  then
    echo "Creating a new $instanceType instance..."
    export instanceId=$(aws ec2 run-instances --image-id $ami --count 1 --instance-type $instanceType --key-name aws-key-$name --security-group-ids $securityGroupId --subnet-id $subnetId --associate-public-ip-address --block-device-mapping file://config/ebs_config.json --query 'Instances[0].InstanceId' --output text --profile $profileName)
    aws ec2 create-tags --resources $instanceId --tags --tags Key=Name,Value=$instanceName --profile $profileName
    export allocAddr=$(aws ec2 allocate-address --domain vpc --query 'AllocationId' --output text --profile $profileName)

    echo "Waiting for instance start..."
    aws ec2 wait instance-running --instance-ids $instanceId --profile $profileName
    sleep 10 # wait for ssh service to start running too

    export assocId=$(aws ec2 associate-address --instance-id $instanceId --allocation-id $allocAddr --query 'AssociationId' --output text --profile $profileName)
    export instanceUrl=$(aws ec2 describe-instances --instance-ids $instanceId --query 'Reservations[0].Instances[0].PublicDnsName' --output text --profile $profileName)

    ## reboot instance, because I was getting "Failed to initialize NVML: Driver/library version mismatch"
    ## error when running the nvidia-smi command
    ## see also http://forums.fast.ai/t/no-cuda-capable-device-is-detected/168/13
    aws ec2 reboot-instances --instance-ids $instanceId --profile $profileName

else
  echo "Non-null value: $instanceId"
fi

echo "Your instance id is: $instanceId"
echo "This instance has the following address: $assocId"
echo "The instance URL is: $instanceUrl"
