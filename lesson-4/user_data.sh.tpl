#!/bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo cat <<EOF > /var/www/html/index.html
<html>
<h2>Build by power terraform! <font color="red"> v1.9.5</font></h2><br>
Owner ${f_name} ${ l_name} <br>

%{ for x in names ~}
Hello to ${x} from ${f_name}<br>
%{endfor ~}

</html>
EOF

sudo systemctl start httpd.service
sudo systemctl enable httpd.service