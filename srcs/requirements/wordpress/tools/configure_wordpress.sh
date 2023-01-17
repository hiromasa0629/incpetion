#!/bin/sh

if [ -e /var/www/html/wp-config.php ]
then
	echo "sup"
else
	mkdir -p /var/www/html
	wget https://wordpress.org/latest.tar.gz
	tar -xzvf latest.tar.gz
	cp -r  wordpress/* /var/www/html/ && rm -rf wordpress

	sed -i "23s/.*/define( 'DB_NAME', '$DATABASE_NAME' );/g" /var/www/html/wp-config-sample.php
	sed -i "26s/.*/define( 'DB_USER', '$DATABASE_USER' );/g" /var/www/html/wp-config-sample.php
	sed -i "29s/.*/define( 'DB_PASSWORD', '$DATABASE_USER_PASS' );/g" /var/www/html/wp-config-sample.php
	sed -i "32s/.*/define( 'DB_HOST', '$DATABASE_HOSTNAME' );/g" /var/www/html/wp-config-sample.php

	sed -i "82s/.*/define( 'WP_DEBUG', true );/g" /var/www/html/wp-config-sample.php
	sed -i "83s/.*/define( 'WP_DEBUG_LOG', true );/g" /var/www/html/wp-config-sample.php

#sed -i "s/database_name_here/$DATABASE_NAME/g" /var/www/html/wp-config-sample.php
#sed -i "s/username_here/$DATABASE_USER/g" /var/www/html/wp-config-sample.php
#sed -i "s/password_here/$DATABASE_USER_PASS/g" /var/www/html/wp-config-sample.php
#sed -i "s/localhost/$DATABASE_HOSTNAME/g" /var/www/html/wp-config-sample.php
	cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

fi

exec "$@"
