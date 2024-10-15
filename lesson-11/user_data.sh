#!/bin/bash
sudo yum -y update
sudo yum -y install httpd


myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`

sudo cat <<EOF > /var/www/html/index.html
<html>
<body bgcolor="black">
<h2><font color="gold">Build by Power of Terraform <font color="red"> v1.9.5</font></h2><br><p>
<font color="green">Server PrivateIP: <font color="aqua">$myip<br><br>

<font color="magenta">
<b>Version v666777</b>
</body>
</html>
EOF

sudo systemctl start httpd.service
sudo systemctl enable httpd.service