#!/bin/bash
yum -y update
yum -y install httpd
myip=`curl http://169.254.169.254/latest/meta-data/public-ipv4`
cat <<EOF > /var/www/html/index.html
<html>
<h2>WebServer with IP : $myip</h2><br>Build by Terraform using external Template"
<br><h2><font color="blue">Owner ${f_name} ${l_name}</font></h2><br>
%{ for x in names ~}
Hello to ${x} from ${f_name}<br>
%{ endfor ~}
</html>
EOF
sudo service httpd start
chkconfig httpd on