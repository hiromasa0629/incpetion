FROM debian:bullseye

MAINTAINER hyap "howzheng0629@gmail.com"
RUN apt-get update
RUN apt-get -y -q install nginx
RUN mkdir -p /var/www/html/website
RUN mkdir -p /etc/nginx/certs

COPY conf/global.conf /etc/nginx/conf.d/
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY tools/ssl/certificate.crt /etc/nginx/certs/
COPY tools/ssl/private.key /etc/nginx/certs/

EXPOSE 80 443

