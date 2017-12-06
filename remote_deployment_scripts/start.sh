#/bin/bash

#================================================================#
# Ubuntu 16.04 Data Science Build Shell Script
#================================================================#
# Built for personal use by Riaz Arbi riazarbi@gmail.com
#================================================================#
#
#
#
#
#
#=================================================================#


echo
echo "This script will crash hard if you are not a sudo user."
echo
sudo echo
sleep 1
echo  
echo "This interactive script will allow you to install, configure and enable:"
echo
echo "NOT OPTIONAL:"
echo "UFW"
echo "Htop"
echo "Automatic Upgrades"
echo
echo "OPTIONAL:"
echo "NextCloud"
echo "JupyterHub"
echo "RStudio Server"
echo "Tor SSH Hidden Service"
echo "Create new regular system users"
echo "Sync new user home folders with the local NextCloud server"
echo
username=$USER
echo "Your username is "$username". This will be the username of the admin user for Jupyterhub, RStudio Server and Nextcloud."
echo "Your password for RStudio Server and JupyterHub will be synchronised to you underlying system user password."
echo "You will be prompted for a password to associate with your Nextcloud Admin account."
echo 
echo "############### This script will DISABLE ssh password access.###############"
echo "############################################################################"
echo "############ You will only be able to log in with a private key ############"
echo "You need to push a private SSH key to this server before running this script"
echo
read -p "Does your initial setup meet the above conditions and do you want to continue? (y/N)? " -n 1 -r
echo
#=================================================================#

if [[ $REPLY =~ ^[yes]$ ]]
  then
  echo "Commencing setup"  
  sleep 1  
  echo "=====================> Setting Working Directory to /~"
  cd ~
  echo "=====================> Updating and upgrading system"
  sudo apt-get update
  sudo apt-get upgrade -y
  echo 

else 
  echo "Exiting"
  exit 0
fi
#=================================================================#


sudo bash ~/remote_deployment_scripts/disable_ssh_password_access.sh
sudo bash ~/remote_deployment_scripts/UFW_setup.sh
sudo bash ~/remote_deployment_scripts/automatic_upgrades_setup.sh
sudo bash ~/remote_deployment_scripts/htop_setup.sh

sudo bash ~/remote_deployment_scripts/nextcloud_setup.sh
sudo bash ~/remote_deployment_scripts/jupyterhub_setup.sh
sudo bash ~/remote_deployment_scripts/rstudio_server_setup.sh
sudo bash ~/remote_deployment_scripts/tor_ssh_setup.sh

sudo sudo bash ~/remote_deployment_scripts/create_user.sh
sudo sudo bash ~/remote_deployment_scripts/summary.sh

