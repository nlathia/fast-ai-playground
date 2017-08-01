#!/bin/bash
#
# Configure a p2.xlarge instance

export instanceType="p2.xlarge"

# Make sure CLI is installed
. $(dirname "$0")/steps/check_awscli_installed.sh

# Set the profile
. $(dirname "$0")/steps/export_profileName.sh

# Set the correct ami
. $(dirname "$0")/steps/export_ami.sh

# Create a VPC, if one doesn't already exist
. $(dirname "$0")/steps/export_vpcId.sh

#. $(dirname "$0")/setup_instance.sh
