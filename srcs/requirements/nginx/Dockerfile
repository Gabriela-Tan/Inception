FROM debian:bullseye

EXPOSE 443

RUN apt-get update -y && apt-get upgrade -y && \
    apt-get install -y nginx curl openssl && \
    mkdir -p /etc/nginx/ssl /run/nginx && \
    openssl req -x509 -nodes -newkey rsa:4096 -days 365 \
    -out /etc/nginx/ssl/inception.crt \
    -keyout /etc/nginx/ssl/inception.key \
    -subj "/C=CZ/ST=PRAGUE/L=PRAGUE/O=42Prague/OU=gabtan/CN=gabtan.42.fr/UID=gabtan"

COPY conf/nginx.conf  /etc/nginx/conf.d/server.conf

CMD [ "nginx", "-g", "daemon off;" ]
