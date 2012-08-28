#!/bin/sh 
#update packages
yum -y update
#install git
yum -y install git
#setup deployment directory
mkdir -p /opt/deploy
cd /opt/deploy
#clone deployment scripts/content to there
git clone https://github.com/johnlabarge/aws
#run its scripts
cd aws
chmod +x bootscript.sh
./bootscript.sh
