#!/bin/bash
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
echo "This non-interactive script will install, configure and enable:"
echo
echo "JupyterHub"
echo "RStudio Server"
echo "UFW"
echo "Tor SSH Hidden Service"
echo
username=$USER
echo "Your username is "$username". This will be the username of the admin user for Jupyterhub and RStudio Server."
echo "Your password for these services will be synchronised to you underlying system user password."
echo 
echo "This script will crash hard if you are not a sudo user."
echo
echo "############### This script will DISABLE ssh password access.###############"
echo "############################################################################"
echo "############ You will only be able to log in with a private key ############"
echo "You need to push a private SSH key to this server before running this script"
echo
read -p "Does your initial setup meet the above conditions and do you want to continue? (y/N)? " -n 1 -r
echo
if [[ $REPLY =~ ^[yes]$ ]]
then
sleep 1
echo
sudo echo
sleep 1
echo "=====================> Setting Working Directory to /~"
cd ~
echo
echo "=====================> Setting up UFW"
echo
sudo apt-get update
sudo apt-get install ufw -y
sudo ufw default allow outgoing
sudo ufw default deny incoming
sudo ufw allow ssh
echo "y" | sudo ufw enable

echo "=====================> Setting up Jupyterhub"
echo "=====================> Installing Packages"
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install python3-pip -y
sudo apt-get install npm nodejs-legacy -y
sudo npm install -g configurable-http-proxy -y
sudo pip3 install jupyterhub
sudo pip3 install --upgrade notebook

echo "=====================> Generating Jupyterhub Config"
jupyterhub --generate-config
sed -i "/c.Authenticator.admin_users/c\c.Authenticator.admin_users = {\'$username\'}" ~/jupyterhub_config.py

echo "=====================> Copying Jupyterhub Startup service to /etc and /lib locations"
sudo cp ~/remote_deployment_scripts/jupyterhub.service /etc/systemd/system/jupyterhub.service
sudo cp /etc/systemd/system/jupyterhub.service /lib/systemd/system/jupyterhub.service

echo "=====================> Enabling Jupyterhub at Startup"
sudo systemctl enable jupyterhub
sudo systemctl start jupyterhub

echo "=====================> Opening up Jupyterhub port 8000"
sudo ufw allow 8000

echo "=====================> Setting Up RStudio Server"
echo "=====================> Adding CRAN GPG key"
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9

echo "=====================> Adding Cran to Ubuntu repos"
echo "# CRAN Repo" | sudo tee -a /etc/apt/sources.list
echo "deb https://cloud.r-project.org/bin/linux/ubuntu xenial/" | sudo tee -a /etc/apt/sources.list

echo "=====================> Installing dependencies"
sudo apt-get update
sudo apt-get install r-base -y
sudo apt-get install gdebi-core dpkg -y

echo "=====================> Getting RStudio Server .deb from website"
echo "######################################################################"
echo "NB: PROBABLY GET THE LATEST RSERVER DEB, THIS ONE IS A HARDLINKED WGET" 
wget https://download2.rstudio.org/rstudio-server-1.1.383-amd64.deb

echo "=====================> Installing RStudio Server"
sudo debi -n rstudio-server-1.1.383-amd64.deb

echo "=====================> Enabling RStudio Server at Startup"
sudo systemctl start rstudio-server
sudo systemctl enable rstudio-server

echo "=====================> Opening up RStudio Server on port 8787"
sudo ufw allow 8787

echo "=====================> Setting up tor-based SSH"
echo "=====================> Adding TOR repo to Ubuntu repos"
echo "deb https://cloud.r-project.org/bin/linux/ubuntu xenial/" | sudo tee -a /etc/apt/sources.list
echo "#Tor Repos" | sudo tee -a /etc/apt/sources.list
echo "deb http://deb.torproject.org/torproject.org xenial main" | sudo tee -a /etc/apt/sources.list
echo "deb-src http://deb.torproject.org/torproject.org xenial main" | sudo tee -a /etc/apt/sources.list

echo "=====================> Adding Tor GPG key"
gpg --keyserver keys.gnupg.net --recv A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89
gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | sudo apt-key add -

echo "=====================> Installing Tor"
sudo apt-get update
sudo apt-get install tor deb.torproject.org-keyring -y 

echo "=====================> Configuring Tor SSH Hidden Service"
sudo mkdir /var/lib/tor/sshd/
sudo chmod 700 /var/lib/tor/sshd/
sudo chown debian-tor.debian-tor /var/lib/tor/sshd/
echo "################## Riaz Added Configs ###################" | sudo tee -a /etc/tor/torrc
echo "HiddenServiceDir /var/lib/tor/sshd/" | sudo tee -a /etc/tor/torrc
echo "HiddenServicePort 22 127.0.0.1:22" | sudo tee -a /etc/tor/torrc


echo "=====================> Enabling Tor at startup"
sudo systemctl enable tor
sudo systemctl start tor
sudo systemctl restart tor
sudo cat /var/lib/tor/sshd/hostname

echo "=====================> Disabling password-based authentication for SSH"
sudo sed -i '/PasswordAuthentication/c\PasswordAuthentication no' /etc/ssh/sshd_config
sudo service ssh restart

fi

#===========================================================================#
echo "######################### END #############################"

