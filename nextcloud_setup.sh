#!/bin/bash

echo
echo "=====================> Setting up Nextcloud Server"
echo "Admin user for nextcloud is " $USER
echo
echo "Please enter a password for your Nextcloud admin account:"
read adminpassword
echo
echo "Please enter the IP address of this server for setting up Nextcloud Trusted Domain:"
read ServerIP
echo
sudo snap install nextcloud
snap changes nextcloud
snap info nextcloud
snap interfaces nextcloud
echo "=====================> Setting up Admin user for Nextcloud"
sudo nextcloud.manual-install $USER $adminpassword
echo
echo "=====================> Setting up this server's IP address as a trusted domain"
sudo nextcloud.occ config:system:get trusted_domains
sudo nextcloud.occ config:system:set trusted_domains 1 --value=$ServerIP
sudo nextcloud.occ config:system:get trusted_domains
sudo nextcloud.enable-https self-signed
echo
#=================================================================#

echo "=====================> Setting up NextCloud Client"
echo
sudo add-apt-repository ppa:nextcloud-devs/client
sudo apt-get update
sudo apt install nextcloud-client -y
echo
#=================================================================#

echo "=====================> Opening Up Ports"
echo
echo "Opening up ports 80 and 443 for Nexcloud"
sudo ufw allow 80,443/tcp
sudo ufw reload
echo
#=================================================================#
echo
