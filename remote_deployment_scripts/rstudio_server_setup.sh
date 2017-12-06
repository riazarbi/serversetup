#!/bin/bash

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
echo "######################################################################"
wget https://download2.rstudio.org/rstudio-server-1.1.383-amd64.deb

echo "=====================> Installing RStudio Server"
#sudo gdebi rstudio-server-1.1.383-amd64.deb
sudo gdebi --non-interactive rstudio-server-1.1.383-amd64.deb

echo "=====================> Enabling RStudio Server at Startup"
sudo systemctl start rstudio-server
sudo systemctl enable rstudio-server

echo "=====================> Opening up RStudio Server on port 8787"
sudo ufw allow 8787
sudo ufw reload
echo

#===========================================================================#

echo "=====================> Installing MikTex"
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D6BC243565B2087BC3F897C9277A7293F59E4889
echo "deb http://miktex.org/download/ubuntu xenial universe" | sudo tee /etc/apt/sources.list.d/miktex.list
sudo apt-get update
sudo apt-get install miktex -y

#===========================================================================#
echo
