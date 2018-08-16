# Sentinel Scripts

First, open the Terminal in your system and change your working directory

`cd ~`

Clone the repo

`git clone https://github.com/sentinel-official/sentinel-utilities.git`

Change your working directory

`cd ~/sentinel-utilities/Node-Management/vpn`

## Launching a single dVPN node

Run the below command for deploying the node. Please note that user must be `root` in the server and give IP_ADDRESS and PASSWORD in single quotes

`bash deploy.sh --deploy 'IP_ADDRESS' 'PASSWORD'`

To check the status of the running Docker container run the below command

`bash deploy.sh --status 'IP_ADDRESS' 'PASSWORD'`

## Launching the multiple dVPN nodes

Create a file *ips.txt* in the current directory with the list of server IPs. Please give one IP for line

Create a file *passwords.txt* in the current directory with the list of passwords for respective servers. Please give one password for line

Run the below command for launching all nodes.

`bash deploy.sh --deploy-many ips.txt passwords.txt`

To check the status of the running Docker containers run the below command

`bash deploy.sh --status-many ips.txt passwords.txt`
