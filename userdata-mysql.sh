#!/bin/bash
set -euxo pipefail

dnf -y update
dnf -y install mariadb105-server

systemctl enable mariadb
systemctl start mariadb

# Allow private connections
sed -i 's/^\(bind-address\|#bind-address\).*/bind-address=0.0.0.0/' /etc/my.cnf.d/mariadb-server.cnf || echo -e "[mysqld]\nbind-address=0.0.0.0" >> /etc/my.cnf.d/mariadb-server.cnf
systemctl restart mariadb

mysql -uroot <<'SQL'
CREATE DATABASE wordpress_db;
CREATE USER 'noor'@'%' IDENTIFIED BY 'onePlus1@';
GRANT ALL PRIVILEGES ON wordpress_db.* TO 'noor'@'%';
FLUSH PRIVILEGES;
SQL
