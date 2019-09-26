#!/usr/bin/env bash

echo "Creating an ssh key for your new EC2"
rm -f key > output.log
rm -f key.pub > output.log
ssh-keygen -f ./key -P "" -N "" > output.log
echo "Initializing terraform modules"
terraform init > output.log
echo "Making sure terraform can perform well"
terraform plan > output.log
echo "Creating your EC2"
terraform apply --auto-approve -target=aws_instance.main > output.log
echo "Provisioning your EC2"
echo "Configuring OpenVPN on your EC2"
terraform apply --auto-approve > output.log
sh display.sh
