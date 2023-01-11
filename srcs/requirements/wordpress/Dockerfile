FROM debian:buster

RUN apt-get update
RUN apt-get install -y php-fpm php-mysql wget

COPY conf/www.conf /etc/php/7.3/fpm/pool.d

COPY ./tools/configure_wordpress.sh /
RUN chmod 777 configure_wordpress.sh

EXPOSE 9000

# if `Unable to create PID file` error occured
RUN mkdir -p /run/php

ENTRYPOINT ["./configure_wordpress.sh"]
CMD ["/usr/sbin/php-fpm7.3", "-F"]
