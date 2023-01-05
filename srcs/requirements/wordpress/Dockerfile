FROM debian:bullseye

RUN apt-get update
RUN apt-get install php7.4-fpm wget

RUN wget -O /tmp/wordpress.tar.gz https://wordpress.org/latest.tar.gz \
	&& tar -C /var/www/html -xzf /tmp/wordpress.tar.gz \
	&& rm /tmp/wordpress.tar.gz

EXPOSE 443
