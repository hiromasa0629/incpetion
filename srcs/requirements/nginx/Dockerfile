FROM debian:bullseye

LABEL	maintainer="hyap howzheng0629@gmail.com" \
		version="1.0" \
		description="Dockerfile for nginx image"

RUN		apt-get update
RUN		apt-get -y -q install nginx openssl
# create a dir to mount webiste volume
RUN		mkdir -p /var/www/html/wordpress
# create a directory for ssl certs
RUN		mkdir -p /etc/nginx/certs
# generate certs with openssl using sh script
COPY	tools/create_ssl.sh /tmp/
RUN		chmod 777 /tmp/create_ssl.sh
RUN		sh /tmp/create_ssl.sh

# copy nginx configuration from local to container
COPY	conf/global.conf /etc/nginx/conf.d/
COPY	conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

# daemon off has already configured in nginx.conf
CMD ["nginx"]

