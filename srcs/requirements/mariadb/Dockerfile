FROM debian:bullseye

EXPOSE 3306

RUN apt-get update -y && apt-get upgrade -y && \
    apt-get install -y mariadb-server

COPY ./conf/mariadb.conf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./conf/mariadb_script.sh /usr/local/bin

RUN chmod +x /usr/local/bin/mariadb_script.sh

ENTRYPOINT [ "bash", "/usr/local/bin/mariadb_script.sh" ]
