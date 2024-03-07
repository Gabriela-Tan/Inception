#!/bin/bash

# Proceed with initialization only if the database directory does not exist
if [ ! -d /var/lib/mysql/$SQL_DATABASE ]; then
# Start MariaDB service
service mariadb start
# Use mariadb command blocks to execute SQL statements
mariadb -u root -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
mariadb -u root -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
mariadb -u root -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
mariadb -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
# Shutdown MariaDB after initialization
mariadb -u root -e "FLUSH PRIVILEGES;"
# Start MariaDB server in the foreground
mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown
fi
exec mysqld_safe
