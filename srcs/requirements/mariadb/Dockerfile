FROM debian:buster

RUN apt-get update
RUN apt-get install -y mariadb-server

# In case of Bind on unix socket: No such file or directory
RUN mkdir -p /run/mysqld
RUN chown -R mysql:root /run/mysqld
RUN chmod 777 /run/mysqld

COPY ./tools/configure_db.sh /
RUN chmod 777 /configure_db.sh

ENTRYPOINT ["./configure_db.sh"]

CMD ["mysqld"]

EXPOSE 3306
