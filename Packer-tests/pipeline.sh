#!/bin/bash
#set -e # abort if there is an issue with any build

# Create temporary file to evade any errors
touch /tmp/vm_encrypted_pass


# Run Step Builds
packer build -only='step-1.null.encrypted-pass' .
packer build -only='step-2.file.user-data' .
packer build -only='step-3.vsphere-iso.linux-ubuntu-server' .


# Remove residual files
FILE=./content/user-data
test -f $FILE && rm $FILE

FILE=/tmp/vm_encrypted_pass
test -f $FILE && rm $FILE
