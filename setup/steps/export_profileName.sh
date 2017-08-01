#!/bin/bash

if [ $# -eq 0 ]
  then
    echo "Setting up using the default profile"
    export profileName="default"
else
    echo "Setting up using the $1 profile"
    export profileName="$1"
fi

if [[ $(aws configure --profile $profileName list) && $? -ne 0 ]]
  then
    echo "Unknown profile! Aborting."
    exit 1
fi

if [ -z "$(aws configure get aws_access_key_id --profile $profileName)" ]; then
    echo "AWS credentials not configured. Aborting."
    exit 1
fi