#!/bin/sh

# Install apache
yum -y install httpd

#partition ebs volume 
sfdisk /dev/sdb <<EOF
,,L,,
EOF
#WAIT A FEW SECONDS - BETTER SOLUTION - CHECK /DEV
echo "wait for partition to become available" 
sleep 5s

#Format ebs volume
mkfs -t ext4 /dev/sdb1

#Mount new filesystem at /www
mkdir -p /www
mount /dev/sdb1 /www

#Get filesystem back on reboot
echo "/dev/sdb1   /www         ext4    defaults        0   0" >>/etc/fstab

#copy web files 
cp -r /opt/deploy/aws/web/* /www

#configure DocumentRoot to point to ebs volume
sed -i.old 's/^DocumentRoot.*/DocumentRoot \"\/www\"/' /etc/httpd/conf/httpd.conf

#make apache start on boot
chkconfig httpd on

#restart apache
/etc/init.d/httpd stop 
/etc/init.d/httpd start




