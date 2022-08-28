#!/bin/bash
#set -e # abort if there is an issue with any build

# Increment build number
n=19;#build number
next_n=$[$n+1]
sed -i "/#build number$/s/=.*#/=$next_n;#/" ${0}
echo $n > content/build.md

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
