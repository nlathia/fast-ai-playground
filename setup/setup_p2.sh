#!/bin/bash
#
# Configure a p2.xlarge instance

# get the profile
if [ $# -eq 0 ]
  then
    echo "Setting up using the default profile"
    export profileName="default"
else
    echo "Setting up using the $1 profile"
    export profileName="$1"
fi

# get the correct ami
export region=$(aws configure get region --profile $profileName)
echo "Setup region is: $region"
if [ $region = "us-west-2" ]; then
   export ami="ami-bc508adc" # Oregon
elif [ $region = "eu-west-1" ]; then
   export ami="ami-b43d1ec7" # Ireland
elif [ $region = "us-east-1" ]; then
  export ami="ami-31ecfb26" # Virginia
else
  echo "Only us-west-2 (Oregon), eu-west-1 (Ireland), and us-east-1 (Virginia) are currently supported"
  exit 1
fi

export instanceType="p2.xlarge"
. $(dirname "$0")/setup_instance.sh
