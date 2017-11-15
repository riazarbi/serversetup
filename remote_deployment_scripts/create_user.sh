#!/bin/bash
echo "This script adds system users"
echo "Users created with this script will have a home folder."
echo "Their home folder will be accessible to via JupyterHub, RStudio Server and NextCloud"
echo "THey will NOT have sudo rights"
echo
echo "Enter the new user's username:"
read added_user
echo
sleep 1
echo "Enter the new user's password:"
read added_password
echo
sleep 1
sudo su -c "useradd $added_user -s /bin/bash -m"
echo $added_user:$added_password | sudo chpasswd
