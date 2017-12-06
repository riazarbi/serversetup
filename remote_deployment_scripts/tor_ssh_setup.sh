#!/bin/bash

#=================================================================#
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
echo
#=================================================================#
echo
