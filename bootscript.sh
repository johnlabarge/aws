#!/bin/sh
yum -y install httpd

sfdisk /dev/sdb <<EOF
,,L,,
EOF

mkfs -t ext4 /dev/sdb1
mkdir -p /www
mount /dev/sdb1 /www

cp -r /opt/deploy/aws/web/* /www

sed -i.old 's/^DocumentRoot.*/DocumentRoot \"\/www\"/' /etc/httpd/conf/httpd.conf

/etc/init.d/httpd stop 
/etc/init.d/httpd start
echo "/dev/sdb1   /www         ext4    defaults        0   0" >>/etc/fstab



