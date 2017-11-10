# serversetup

### Introduction and Disclaimer
This is my personal set of scripts for customizing a basic Ubuntu server install. 

It taskes a fresh Ubuntu 16.04 Server and -

1) Disables password authentication for SSH access.
2) Configures UFW firewall.
3) Installs, configures and enables Jupyterhub Server on port 8000.
4) Installs, configures and enables RStudio Server on port 8787.
5) Installs, configures and enables Tor Hidden Service for SSH remote access.

At present, this works but it's not elegant and has no bells and whistles. Things may or may not work. There is no error handling, so make sure you actually have a remote server that you can access with an IP address and thatyou have sudo rights on that remote server beforehand. You shouldn't run this twice. It'll work, but it will clog your `sources.list` with duplicates, re-`wget` files etc.

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
10) After checking that you actually want to do this and getting your sudo password, `start.sh` will non-interactively do what it needs to. When it's done it will give you a summary.

### TO DO
* Break out the large install script into smaller chained scripts
* Create a 'select what to configure' dialog at top of start.sh
* Limit SSH access to existing user only
* Turn Tor hidden service into a stealth service
* Add h2o.ai to the installed services
* Add a 'create new users' dialog to create safe (non-sudo) users who will be the actual users of the web services.
* Install and configure Tex so that RStudio and Jupyter can write .Rmd and .ipynb files to PDF.
