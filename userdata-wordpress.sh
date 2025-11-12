#!/bin/bash
set -euxo pipefail

# Template variable from Terraform
DB_HOST="${db_host}"

dnf -y update
dnf -y install httpd php php-mysqlnd wget unzip

systemctl enable httpd
systemctl start httpd

cd /var/www/html
wget https://wordpress.org/latest.zip
unzip -q latest.zip
cp -r wordpress/* .
rm -rf wordpress latest.zip

chown -R apache:apache /var/www/html

mv wp-config-sample.php wp-config.php
sed -i "s/database_name_here/wordpress_db/" wp-config.php
sed -i "s/username_here/noor/" wp-config.php
sed -i "s/password_here/onePlus1@/" wp-config.php
sed -i "s/localhost/${db_host}/" wp-config.php

systemctl restart httpd
