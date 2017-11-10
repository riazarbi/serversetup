# serversetup

### Introduction and Disclaimer
This is my personal set of scripts for customizing a basic Ubuntu server install. 

When complete, it will take a fresh Ubuntu 16.04 Server and -

1) Disable password authentication for SSH access.
2) Configure UFW firewall.
3) Install, configure and enable Jupyterhub Server on port 8000.
4) Install, configure and enable RStudio Server on port 8787.
5) Install, configure and enable Tor Hidden Service for SSH remote access.
6) Create regular users via prompts.

It is a very rough work in progress. Things may or may not work.

### The Plan
Eventually, you should be avble to use this repo in the following way:

1) Initialize a remote Ubuntu 16.04 server. It needs (a) SSH access (b) a sudo user. You need to know its IP address.
2) Clone this repo to your local machine
3) Open terminal.
4) type: `cd serversetup`
5) Enter `./set_up_remote_server.sh`
4) Enter the remote sudo user and remote IP when prompted
5) The script will generate a local SSH key if needed. You can choose not to overwrite your existing key if you'd rather keep it.
6) The script will send the key to the remote server. Enter your remote sudo password to send the key.
7) The script will securely transfer the `remote_deployment_scripts` folder to the remote server.
8) The script will SSH into the remote server and then wait for your prompts
-----ON THE REMOTE SERVER------
9) The script will cd into the `remote_deployment_scripts` folder and list the folder contents.
10) You'll have to enter `bash start.sh`
10) `start.sh` will prompt you to specify what setup chunks you want to execute. Default is that all setup chunks are excuted. Select what you want and then let it do its thing.

### Development Status
The Plan is not ready yet. The scripts sort of work. There is only one script in the `remote_deployment_scripts` folder; it needs to be broken out onto a master script (with dialogs) and setup chunks. Will try clean up before 20 Nov '17 when I have time.

