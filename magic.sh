#!/usr/bin/env bash

echo "Creating an ssh key for your new EC2"
rm -f key
rm -f key.pub
ssh-keygen -f ./key -P "" -N ""
echo "Initializing terraform modules"
terraform init
echo "Making sure terraform can perform well"
terraform plan
echo "Creating your EC2"
terraform apply --auto-approve -target=aws_instance.main
echo "Provisioning your EC2"
terraform apply --auto-approve -target=null_resource.provisioner_install
terraform apply --auto-approve -target=null_resource.provisioner_config
echo "Configuring OpenVPN on your EC2"
terraform apply --auto-approve
sh display.sh
