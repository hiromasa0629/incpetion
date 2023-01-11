#!/bin/sh

sed -i "s/127.0.0.1/0.0.0.0/g" /etc/mysql/mariadb.conf.d/50-server.cnf

service mysql start && \
mysqladmin -u root password "$DATABASE_ROOT_PASS" && \
mysql -u root -p"$DATABASE_ROOT_PASS" -e "SET PASSWORD FOR 'root'@localhost = PASSWORD('$DATABASE_ROOT_PASS');" && \
mysql -u root -p"$DATABASE_ROOT_PASS" -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1')" && \
mysql -u root -p"$DATABASE_ROOT_PASS" -e "DELETE FROM mysql.user WHERE User=''" && \
mysql -u root -p"$DATABASE_ROOT_PASS" -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%'" && \
mysql -u root -p"$DATABASE_ROOT_PASS" -e "CREATE USER '$DATABASE_USER'@'%' IDENTIFIED BY '$DATABASE_USER_PASS'" && \
mysql -u root -p"$DATABASE_ROOT_PASS" -e "GRANT ALL PRIVILEGES ON $DATABASE_NAME.* TO '$DATABASE_USER'@'%'" && \
mysql -u root -p"$DATABASE_ROOT_PASS" -e "FLUSH PRIVILEGES"

chown -R mysql:mysql "/var/lib/mysql/$DATABASE_NAME"

mysql -u root -p"$DATABASE_ROOT_PASS" "$DATABASE_NAME" < "./$DATABASE_NAME.sql"

sed -i "5s/.*/password = $DATABASE_ROOT_PASS/;10s/.*/password = $DATABASE_ROOT_PASS/" /etc/mysql/debian.cnf
service mysql stop

exec "$@"
