#!/bin/bash

echo
echo "=====================> Setting up Automatic Upgrades"
sudo apt-get install unattended-upgrades
sudo dpkg-reconfigure unattended-upgrades
#=================================================================#
echo
