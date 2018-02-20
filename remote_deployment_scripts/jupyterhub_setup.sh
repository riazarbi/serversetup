#!/bin/bash

echo
echo "=====================> Setting up Jupyterhub"
echo "=====================> Installing Packages"
sudo apt-get update
sudo apt-get install python3-pip -y
sudo apt-get install npm nodejs-legacy -y

npm -v
sudo npm cache clean -f
sudo n stable
npm -v

sudo npm install -g configurable-http-proxy
sudo pip3 install jupyterhub
sudo pip3 install --upgrade notebook

echo "=====================> Generating Jupyterhub Config"
jupyterhub --generate-config
sed -i "/c.Authenticator.admin_users/c\c.Authenticator.admin_users = {\'$username\'}" ~/jupyterhub_config.py

echo "====================> Installing Jupyterlab"
sudo pip3 install jupyterlab
sudo jupyter serverextension enable --py jupyterlab --sys-prefix
jupyter labextension install @jupyterlab/hub-extension
sed -i "/c.Spawner.default_url/c\c.Spawner.default_url = '/lab'" ~/jupyterhub_config.py

echo "=====================> Copying Jupyterhub Startup service to /etc and /lib locations"
sudo cp ~/remote_deployment_scripts/jupyterhub.service /etc/systemd/system/jupyterhub.service
sudo cp /etc/systemd/system/jupyterhub.service /lib/systemd/system/jupyterhub.service

echo "=====================> Enabling Jupyterhub at Startup"
sudo systemctl enable jupyterhub
sudo systemctl start jupyterhub

echo "=====================> Opening up Jupyterhub port 8000"
sudo ufw allow 8000
sudo ufw reload
echo

#=================================================================#
