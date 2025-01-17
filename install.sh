#!/usr/bin/env bash

sudo apt update && sudo apt -y install ca-certificates wget net-tools gnupg
sudo wget -qO - https://as-repository.openvpn.net/as-repo-public.gpg | sudo apt-key add -
sudo echo "deb [arch=amd64] http://as-repository.openvpn.net/as/debian xenial main">/etc/apt/sources.list.d/openvpn-as-repo.list
sudo apt update && sudo apt -y install openvpn-as
sudo echo openvpn:openvpn| /usr/sbin/chpasswd
