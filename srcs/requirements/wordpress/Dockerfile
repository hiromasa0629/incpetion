FROM debian:bullseye

RUN apt-get update
RUN apt-get install php-fpm wget

COPY conf/www.conf /etc/php/7.4/fpm/pool.d

# RUN wget https://wordpress.org/latest.tar.gz \
# 	&& tar -xzvf latest.tar.gz \
# 	&& cp -r wordpress/* /var/www.html \
# 	&& rm -rf wordpress

EXPOSE 443
