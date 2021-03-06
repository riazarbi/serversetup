## Description of what each file in this folder does
All of these scripts are intended to be standalone scripts; you should be able to run them on their own to configure a particular program or service. After your initial install, it's probably best to run the individual scripts to modify parts of the system to avoid clogging the sources.list and re-downloading stuff that doesn't need to be downloaded.

### Generic _setup.sh files
Any file with a _setup.sh suffix generally installs and configures a program or functionality. You can edit these files to modify how that particular fiunctionality is installed.

### Other, special *.sh files
#### start.sh
This is the master script that executes all the others in an interactive manner. It should be the only script you run when setting up a new system.

#### create_user.sh
This script will add non-sudo users to the system. 
It needs to elevate to root.
If the system has NextCloud server installed it will also create a NextCloud user and sync the NextCloud account with the user's home directory every 5 minutes. 
NextCloud sync daemon only deletes a file if it has been deleted on the NextCloud server, so get your users to use NextCloud WebUI as their file manager.
If NextCloud server has not been installed it just sets up a regular system user and then exits.

#### summary.sh
This script will display a summary of the server's networking and firewall rules.
It will display
- The current username
- The ports currently being listened on
- The LAN IP address associated with the server
- The UFW rules in force
- The TOR hostname
