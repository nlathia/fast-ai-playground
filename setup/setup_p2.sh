#!/bin/bash
#
# Configure a p2.xlarge instance

# uncomment for debugging
# set -x

# Abort if any command fails
set -e

# Settings
export instanceType="p2.xlarge"  # t2.xlarge
export name="fast-ai"
export cidr="0.0.0.0/0"

# Make sure CLI is installed
. $(dirname "$0")/steps/check_awscli_installed.sh

# Set the profile
. $(dirname "$0")/steps/export_profileName.sh

# Set the correct ami
. $(dirname "$0")/steps/export_ami.sh

# Create a VPC, if one doesn't already exist
. $(dirname "$0")/steps/export_vpcId.sh

# Create/attach an Internet Gateway Id, if one doesn't already exist
. $(dirname "$0")/steps/export_internetGatewayId.sh

# Create/export subnet id
. $(dirname "$0")/steps/export_subnetId.sh

# Create/export route table
. $(dirname "$0")/steps/export_routeTable.sh

# Create/export security group
. $(dirname "$0")/steps/export_securityGroup.sh

# Create/check SSH key-pair
. $(dirname "$0")/steps/create_ssh_key_pair.sh

# Create the instance, if it doesn't already exist
. $(dirname "$0")/steps/create_instance.sh

# Create/update the shortcuts
. $(dirname "$0")/steps/create_shortcuts.sh

# Create uninstall.sh
. $(dirname "$0")/steps/create_uninstall.sh

echo Finished.
