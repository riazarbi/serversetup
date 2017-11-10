#!/bin/bash
echo
echo "Creating a new local private key."
echo "If you already have one then don't overwrite"
echo
ssh-keygen -t rsa
echo
echo "Enter remote IP address:"
read remoteIPaddress
echo
echo "Enter remote sudo username:"
read remoteSUDOUSER
echo
echo "Attempting to send key to remote server"
echo
ssh-copy-id $remoteSUDOUSER@$remoteIPaddress
echo
echo "Sending setup scripts to remote server"
echo
scp -r remote_deployment_scripts $remoteSUDOUSER@$remoteIPaddress:~/
echo
echo "Hopefully that worked!"
echo "You should be able to continue the server setup by using the scripts in the"
echo "~/setup_scripts directory."
echo
echo "Logging in to remote server"
echo "###################################################"
echo "################LEAVING LOCAL MACHINE##############"
echo "###################################################"
echo 
ssh $remoteSUDOUSER@$remoteIPaddress
ssh $remoteSUDOUSER@$remoteIPaddress 'bash -s' < ~/remote_deployment_scripts/start.sh

