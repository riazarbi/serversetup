#!/bin/bash
echo

echo "=====================> Disabling password-based authentication for SSH"
sudo sed -i '/PasswordAuthentication/c\PasswordAuthentication no' /etc/ssh/sshd_config
sudo service ssh restart
echo "Done."
#=================================================================#

echo
