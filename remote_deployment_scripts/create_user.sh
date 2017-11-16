#!/bin/bash
echo "This script adds system users"
echo "Users created with this script will have a home folder."
echo "Their home folder will be accessible to via JupyterHub, RStudio Server and NextCloud"
echo "They will NOT have sudo rights"
echo "You're going tho have to enter passwords a LOT of times while this script is running. But it's relatively quick."
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
  sudo adduser $added_user

  echo "Now we're going to set up a 5 minute rpeeating task to sync "$added_user"'s NexCloud account and Home folder."
  echo
  echo "Logging into "$added_user"'s account."
  su $added_user
  echo "Adding the 5 minute schedule to the user's crontab"
  echo
  echo "Enter "$added_user"'s NextCloud account password."
  read added_password
  (crontab -l 2>/dev/null; echo "nextcloudcmd -u $added_user -p $added_password -s /home/username/ https://localhost/remote.php/webdav/") | crontab -
  #nextcloudcmd -u $added_user -p $added_password -s /home/username/ https://localhost/remote.php/webdav/

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
