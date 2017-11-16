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

sudo nextcloud.occ user:add --password-from-env $added_user
echo

echo "If your Nextcloud password was too weak you'll have to abort."
read -p "Do you want to continue? [y/N] " prompt
if [[ $prompt == "y" || $prompt == "Y" || $prompt == "yes" || $prompt == "Yes" ]]
then

  echo "Creating user on the JupyterHub/RStudio server..."
  echo
  useradd -m $added_user
  echo $added_password | passwd $added_user --stdin

  echo "Now we're going to set up a 5 minute rpeeating task to sync "$added_user"'s NexCloud account and Home folder."
  if [ "$(whoami)" != "root" ]
  then
      sudo su -s "$0"
      exit
  fi
  echo "Enter "$added_user"'s password."
  echo "Adding a 5 minute sync between "$added_user"'s Home folder and NextCloud account to the root crontab."
  (crontab -l 2>/dev/null; echo "*/5 * * * * su $added_user nextcloudcmd -u $added_user -p $added_password -s /home/$added_user/ https://localhost/remote.php/webdav/") | cr$
  echo "Done. To delete files, use the NextCloud interface. Deletions done via JupyterHub or RStudio will be undone. Additions will be persistent, however."
  echo

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
