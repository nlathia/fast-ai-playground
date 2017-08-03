#!/bin/bash
#
# Configure a p2.xlarge instance

# uncomment for debugging
# set -x

# Abort if any command fails
set -e

# Settings
# Why? When you will launch your instance, it will need: --instance-type $instanceType
export instanceType="p2.xlarge"  # t2.xlarge
export name="fast-ai"
export cidr="0.0.0.0/0"

# Make sure CLI is installed
# Why? Everything below needs the AWS CLI
. $(dirname "$0")/steps/check_awscli_installed.sh

# Set the profile
# Why? All of the following will be done with the credentials set in $profileName
. $(dirname "$0")/steps/export_profileName.sh

# Set the correct ami
# Why? When you will launch your instance, it will need: --image-id $ami
. $(dirname "$0")/steps/export_ami.sh

# Create a VPC, if one doesn't already exist
# Why? p2.xlarge instance types are only available in a VPC
# http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-vpc.html#vpc-only-instance-types
. $(dirname "$0")/steps/export_vpcId.sh

# Create/attach an Internet Gateway Id
# Why? An Internet gateway is a VPC component that allows communication between instances in your VPC and the Internet.
. $(dirname "$0")/steps/export_internetGatewayId.sh

# Create/export subnet id
# Why? When you will launch your instance, it will need: --subnet-id $subnetId
# VPC-only instances need to specify a subnet ID
. $(dirname "$0")/steps/export_subnetId.sh

# Create/export route table
# Why? Each subnet in your VPC must be associated with a route table; the table controls the routing for the subnet.
. $(dirname "$0")/steps/export_routeTable.sh

# Create/export security group
# Why? When you will launch your instance, it will need: --security-group-ids $securityGroupId
# When you launch an instance, you associate one or more security groups with the instance. You add rules to each security group that allow traffic to or from its associated instances.
. $(dirname "$0")/steps/export_securityGroup.sh

# Create/check SSH key-pair
# Why? When you will launch your instance, it will need: --key-name aws-key-$name
. $(dirname "$0")/steps/create_ssh_key_pair.sh

# Create the instance. This is what we've been working to!
. $(dirname "$0")/steps/create_instance.sh

# Create/update the shortcuts: .sh files to quickly start/stop/reboot instances.
. $(dirname "$0")/steps/create_shortcuts.sh

# Create uninstall.sh: to remove all of the above from AWS.
. $(dirname "$0")/steps/create_uninstall.sh

echo Finished.
