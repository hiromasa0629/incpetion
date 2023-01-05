# **Inception 42**

## **Start of the project** (M1 Mac)
Because the subject requires us to do this project in a virtual machine so here is the link for downloading vm for M1 Macs, [Install UTM](https://mac.getutm.app/). To set up the vm, it similar to how it was set up in 42 B2Br project.

---
Make sure you have installed ufw and allowed certain ports
## **NGINX** (some key notes)
- Add `daemon off;` in main block (outside of http, events, server blocks)
- Configure nginx server block:
  - `listen` on port 443
  - `ssl_protocols` TLSv1.2 TLSv1.3
  - configure path for certificate and key for ssl
  - configure `server_name` (eg. domian name)
  - `root` (dir where wordpress is extracted)
  - configure `fastcgi` in `location ~ \.php$` block which is a regular expression that matches any URI that ends with ".php",

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

