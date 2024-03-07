#!/bin/bash

# Wait for MariaDB to be ready
until mariadb --host=mariadb --user="$SQL_USER" --password="$SQL_PASSWORD" -e '\c'; do
    echo >&2 "MariaDB is not ready yet"
    sleep 2
done

# Navigate to WordPress directory
cd /var/www/wordpress || exit

# Create wp-config.php if it doesn't exist
if [ ! -f wp-config.php ]; then
    wp config create --allow-root --dbname="$SQL_DATABASE" --dbuser="$SQL_USER" --dbpass="$SQL_PASSWORD" --dbhost="mariadb:3306"
fi

# Install WordPress core
wp core install --url="$DOMAIN_NAME/" --title="$WEBSITE_TITLE" --admin_user="$ADMIN_USER" --admin_password="$ADMIN_PASSWORD" --admin_email="$ADMIN_EMAIL" --skip-email --allow-root

# Create a new WordPress user
wp user create "$USER1_LOGIN" "$USER1_EMAIL" --role=editor --user_pass="$USER1_PASSWORD" --allow-root

# Install and activate the Twenty Twenty-Two theme
wp theme install twentytwentytwo --activate --allow-root

# Configure Redis settings and install Redis plugin
wp config set WP_REDIS_HOST redis --add --allow-root
wp config set WP_REDIS_PORT 6379 --add --allow-root  
wp config set WP_CACHE true --add --allow-root  
wp plugin install redis-cache --activate --allow-root
wp plugin update --all --allow-root

# Ensure the PHP-FPM run directory exists
mkdir -p /run/php

# Start PHP-FPM in the foreground
/usr/sbin/php-fpm7.4 -F
