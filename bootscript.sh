#!/bin/sh
yum -y install httpd
ls /etc/httpd > ~/tmpfile

sfdisk /dev/sdb <<EOF
,,L,,
EOF

mkfs -t ext4 /dev/sdb1
mkdir -p /www
mount /dev/sdb1 /www

cp -r /opt/deploy/web/* /www

sed -i.old 's/^DocumentRoot.*/DocumentRoot \"\/www\"/' /etc/httpd/conf/httpd.conf

/etc/init.d/httpd stop 
/etc/init.d/httpd start




