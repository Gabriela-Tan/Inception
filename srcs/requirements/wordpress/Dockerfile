FROM debian:bullseye

EXPOSE 9000

RUN apt-get update -y && apt-get upgrade -y && \
    apt-get install -y wget php7.4 php7.4-fpm php-mysql mariadb-client curl redis-server php-redis && \
    wget https://wordpress.org/wordpress-6.3.tar.gz -P /var/www/ && \
    tar -xzf /var/www/wordpress-6.3.tar.gz -C /var/www/ && \
    rm -rf /var/www/wordpress-6.3.tar.gz && \
    chown -R root:root /var/www/wordpress && \
    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp && \
    chmod +x /usr/local/bin/wp

COPY ./conf/php.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY conf/wordpress_script.sh /usr/local/bin/wordpress_script.sh

RUN chmod +x /usr/local/bin/wordpress_script.sh

WORKDIR /var/www/wordpress

ENTRYPOINT [ "bash", "/usr/local/bin/wordpress_script.sh" ]
