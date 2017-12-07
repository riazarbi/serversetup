#!/bin/bash

echo
echo "=====================> Setting up UFW"
sudo apt-get install ufw -y
sudo ufw default allow outgoing
sudo ufw default deny incoming
echo "Opening up ports 22 for SSH access"
sudo ufw allow ssh
echo
echo "y" | sudo ufw enable
#=================================================================#
echo
