FROM debian:bullseye

RUN apt-get update
RUN apt-get install -y php-fpm wget

COPY conf/www.conf /etc/php/7.4/fpm/pool.d

RUN mkdir -p /var/www/html
RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xzvf latest.tar.gz
RUN cp -r  wordpress/* /var/www/html/
RUN rm -rf wordpress

EXPOSE 9000

# if `Unable to create PID file` error occured
RUN mkdir -p /run/php
CMD ["/usr/sbin/php-fpm7.4", "-F"]
