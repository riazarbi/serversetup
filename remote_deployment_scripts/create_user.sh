#!/bin/bash
echo "This script adds users to the system."
echo "Users created with this script will have a Home folder."
echo "Their Home folder will be accessible to via JupyterHub and RStudio Server and synced to NextCloud."
echo "They will NOT have sudo rights."
echo "You're going tho have to enter passwords a LOT of times while this script is running. But it's relatively quick."
echo
echo "Attempting to elevate to root."
sudo echo

if [ "$(whoami)" != "root" ]
  then
    sudo su -s "$0"
    echo "Fail. Run this script as a sudo user."
    exit
fi

echo "Root elevation success."
echo "Enter the new user's username:"
read added_user
echo
sleep 1
echo "Enter the new user's password:"
read added_password
echo
sleep 1

echo "Creating user on the NextCloud Server..."
export OC_PASS=$added_password

nextcloud.occ user:add --password-from-env $added_user
echo

echo "If your Nextcloud password was too weak you'll have to abort."
read -p "Do you want to continue? [y/N] " prompt
if [[ $prompt == "y" || $prompt == "Y" || $prompt == "yes" || $prompt == "Yes" ]]
then
  echo
  echo "Creating user on the JupyterHub/RStudio server..."
  echo
  useradd -m $added_user
  echo $added_user:$added_password | chpasswd
  echo "Created new system user "$added_user" with password "$added_password"."
  echo
  echo "Now we're going to set up a 5 minute repating task to sync "$added_user"'s NexCloud account and Home folder."
  echo
  echo "Adding sync script to the root crontab."
  (crontab -l 2>/dev/null; echo "*/5 * * * * su $added_user nextcloudcmd -u $added_user -p $added_password -s /home/$added_user/ https://localhost/remote.php/webdav/") | crontab -
  echo
  echo "Done. To delete files, use the NextCloud interface."
  echo "Deletions done via JupyterHub or RStudio will be undone by the NextCloud server."
  echo "Additions and modifications are will be persistent no matter where they are done."
  echo

else
  echo
  echo "Aborting."
  echo

fi

read -p "Do you want to run the user creation script again? [y/N] " prompt
if [[ $prompt == "y" || $prompt == "Y" || $prompt == "yes" || $prompt == "Yes" ]]
then
  echo
  bash create_user.sh
  echo
else
  echo
  echo "Goodbye."
  echo
  exit 0
fi

