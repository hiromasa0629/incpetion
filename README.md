# **Inception 42**

## **Start of the project** (M1 Mac)
Because the subject requires us to do this project in a virtual machine so here is the link for downloading vm for M1 Macs, [Install UTM](https://mac.getutm.app/). To set up the vm, it similar to how it was set up in 42 B2Br project.

---
Make sure you have installed ufw and allowed port 443 for https
## **NGINX** (some key notes)
- Add `daemon off;` in main block (outside of http, events, server blocks)
- Configure nginx server block:
  - `listen` on port 443
  - `ssl_protocols` TLSv1.2 TLSv1.3
  - configure path for certificate and key for ssl
  - configure `server_name` (eg. domian name)
  - `root` (dir where wordpress is extracted)

Dockerfile:
```Dockerfile
FROM debian:bullseye # pull debian image

RUN mkdir -p /path/to/html	# dir for mounting volumne

COPY conf/global.conf /path/to/nginx/conf.d/	# configuration for nginx server block
COPY conf/nginx.conf /path/to/nginx/nginx.conf	# configuration for main, events, http blocks

EXPOSE 443 # https port
```
Docker compose
```yml
# define nginx service
nginx:
  image: # image name (tag it with anything other than latest)
  container_name: # container name
  build: # /path/to/Dockerfile_directory
  ports: # map port to contianer exposed port (list)
  volumes: # map local directory to a container directory (list)
  restart: always # it will restart on any exit code
```

## **PHP-FPM** (FastCGI Process Manager)
- It is used to execute PHP scripts in web server environment like NGINX and Apache.
- Modify nginx.conf server block again with configuring `fastcgi` in `location ~ \.php$` block which is a regular expression that matches any URI that ends with ".php".
- Configure `www.conf` in /etc/php/\<version>/fpm/pool.d to listen on port 9000

## **Wordpress**
- use `wget` to download the zipped file from wordpress and extract it and copy all the files in wordpress to /var/html/www

## **MariaDB**
- set new password for mysql root user using `mysqladmin`
- disable remote connection to mysql root user
- set bind-address to `0.0.0.0` in `50-server.cnf`
- create a new mysql user and allow remote access `%`
- grant all privileges of the wordpress db to the new user
- insert root password to `debian.cnf` (incase permission denied to start/stop mysql)
- edit and configure wp-config-sample.php in wordpress container for database connection, make sure hostname is the mariadb container name
- use `mysqldump` to create a sql script after you have created 2 users through the wordpress installation and admin page
- In case of permission denied on creating tables or etc. make sure the database directory is belongs to `mysql` not `root`

## Notes
- `RUN` instruction in `Dockerfile` is begin executed during build time, thus env vriable in .env will not work. `ARG` can be used in `Dockerfile` for build time arguments (but not suitable if contain sensitive infos)
- `ENTRYPOINT` and `CMD` works almost the same except if `ENTRYPOINT` exists, `CMD` will be passed as arguments to `ENTRYPOINT`. If `ENTRYPOINT` is executing an `sh` file, make sure add `exec "$@"` at the end of the `sh` file so it will execute `CMD`
- When sepcifying volumes name in `docker-compose.yml`, note that the device section will not accept relative path.

