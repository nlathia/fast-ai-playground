#!/bin/bash
#
# Configure a p2.xlarge instance

# uncomment for debugging
# set -x

# Settings
export instanceType="p2.xlarge"
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

#. $(dirname "$0")/setup_instance.sh