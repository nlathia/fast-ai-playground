#!/bin/bash

if [ ! -d ~/.ssh ]
then
	mkdir ~/.ssh
fi

key_file=~/.ssh/aws-key-$name.pem
if [ ! -f $key_file ]
  then
    echo "Creating a new SSH key-pair..."
	aws ec2 create-key-pair --key-name aws-key-$name --query 'KeyMaterial' --output text > $key_file --profile $profileName
	chmod 400 $key_file
else
  echo "SSH key-pair already exists!"
fi
