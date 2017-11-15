#!/bin/bash
echo "This script adds system users"
echo "Users created with this script will have a home folder."
echo "Their home folder will be accessible to via JupyterHub, RStudio Server and NextCloud"
echo "They will NOT have sudo rights"
echo
echo "Enter the new user's username:"
read added_user
echo
sleep 1

echo "Creating user on the NextCloud Server..."
sudo nextcloud.occ user:add $added_user
echo

echo "If your Nextcloud password was too weak you'll have to abort."
read -p "Do you want to continue? [y/N] " prompt
if [[ $prompt == "y" || $prompt == "Y" || $prompt == "yes" || $prompt == "Yes" ]]
then

  echo "Creating user on the JupyterHub/RStudio server..."
  echo
  adduser $added_user

else
  echo
fi

read -p "Do you want to run the user creation script again? [y/N] " prompt
if [[ $prompt == "y" || $prompt == "Y" || $prompt == "yes" || $prompt == "Yes" ]]
then
  bash create_user.sh
else
  echo "Goodbye."
  echo
  exit 0
fi

# To implement: set up automatic cron job to sync home folder to Nextcloud.
# 1 Test this command
# Add it to crontab programmatically
# mabye you need to change to user
# write out current crontab
# crontab -l > mycron
## echo new cron into cron file
# echo "00 09 * * 1-5 echo hello" >> mycron
## install new cron file
# crontab mycron
# rm mycron

# I think this works
#(crontab -l 2>/dev/null; echo "*/5 * * * * /path/to/job -with args") | crontab -
#nextcloudcmd -u $added_user -p $added_password -s /home/username/ https://localhost/remote.php/webdav/
