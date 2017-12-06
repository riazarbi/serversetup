## Description of what each file does
### start.sh
This is the master script that executes all the others in an interactive manner. It should be the only script you run when setting up a new system.

### create_user.sh
This script will add non-sudo users to the system. 
It needs to elevate to root.
If the system has NextCloud server installed it will also create a NextCloud user and sync the NextCloud account with the user's home directory every 5 minutes. 
NextCloud sync daemon only deletes a file if it has been deleted on the NextCloud server, so get your users to use NextCloud WebUI as their file manager.
If NextCloud server has not been installed it just sets up a regular system user and then exits.

### summary.sh
This script will display a summary of the server's networking and firewall rules.
It will display
- the current username
- The ports currently being listened on
- The LAN IP address associated with the server
- The UFW rules in force
- The TOR hostname
