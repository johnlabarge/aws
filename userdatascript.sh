#!/bin/sh 
yum -y git
mkdir -p /opt/deploy
cd /opt/deploy
git clone https://github.com/johnlabarge/aws
cd aws
chmod +x bootscript.sh
./bootscript.sh
