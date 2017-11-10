#!/bin/bash
echo
echo "####################### SUMMARY ###########################"
echo
echo "Your username is "$username.
echo
echo "These are the ports currently being listened on"
netstat -lntu
echo
echo "Thease are the IP addresses associated with this server"
sudo ifconfig | awk '/inet addr/{print substr($2,6)}'
echo
echo "These are the UFW rules in force."
sudo ufw status
echo
echo "This is the Tor hostname. Keep it a secret. You can use it to connect to this server over the Tor network."
sudo cat /var/lib/tor/sshd/hostname
echo
echo "##################### END SUMMARY #########################"
