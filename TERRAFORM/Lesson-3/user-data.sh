#!/bin/bash
yum -y update
yum -y install httpd
myip=`curl http://169.254.169.254/latest/meta-data/public-ipv4`
echo "<h2>WebServer with IP : $myip</h2><br>Build by Terraform using external script" > /var/www/html/index.html
echo "<br><h2><font color="blue">Hello World!!</font></h2>" >> /var/www/html/index.html
sudo service httpd start
chkconfig httpd on