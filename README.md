# serversetup

### Introduction and Disclaimer
This is my personal set of scripts for customizing a basic Ubuntu server install. 

It taskes a fresh Ubuntu 16.04 Server and -

1) Disables password authentication for SSH access.
2) Installs some favourite sysadmin utilities (Htop).
3) Configures UFW firewall.
4) Installs and configures a NextCloud Server.
5) Installs and configures my Data Science stack (JupyterHub, RStudio Server, MIkTex).
6) Installs, configures and enables Tor Hidden Service for SSH remote access.
7) Creates non-standard users and syncs their home directories with the NextCloud server.

At present, this works but it's not elegant and has no bells and whistles. Things may or may not work. There is no error handling, so make sure you actually have a remote server that you can access with an IP address and thatyou have sudo rights on that remote server beforehand. You shouldn't run this twice. It'll work, but it will clog your `sources.list` with duplicates, re-`wget` files etc.

### Security
This configuration is not intended to be exposed to the open internet. SSH key-based auth and UFW rules lock it down somewhat, but the JupyterHub and RStudio Server WebUIs are not secure. If you want to expose this to the open internet, either close all non-ssh ports with UFW and SOCKS PROXY in, or install OpenVPN server and distribute keys to people who will access it. 

### How to use
1) Initialize a remote Ubuntu 16.04 server. It needs (a) SSH access (b) a sudo user. You need to know its IP address.
2) Clone this repo to your *local* machine
3) Open terminal.
4) Get into the repo directory - type: `cd serversetup`
5) Enter `./set_up_remote_server.sh`
4) Enter the remote sudo user and remote IP when prompted
5) The script will generate a local SSH key if needed. You can choose not to overwrite your existing key if you'd rather keep it.
6) The script will send the key to the remote server. Enter your remote sudo password to send the key.
7) The script will securely transfer the `remote_deployment_scripts` folder to the remote server.
8) The script will SSH into the remote server and then wait for your prompts.

-----ON THE REMOTE SERVER------

9) The script will cd into the `remote_deployment_scripts` folder and list the folder contents.
10) You'll have to enter `bash start.sh` to start the set up process.
10) After checking that you actually want to do this and getting your sudo password, `start.sh` will start working through the install process. I've tried to make it as non-interactive as possible, but you'll still have to enter prompts form time to time - feel free to fix this and commit!

### TO DO
* Create a 'select what to configure' dialog at top of start.sh
* Limit SSH access to standard users only
* Add h2o.ai to the installed services
* Configure SSL for Jupyterhub
* Configure SSL for RStudio
* Eliminate prompts
* Configure OpenVPN and create client keys for each user, and place then in each user's home directory.
