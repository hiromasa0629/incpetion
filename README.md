# **Inception 42**

## **Start of the project** (M1 Mac)
Because the subject requires us to do this project in a virtual machine so here is the link for downloading vm for M1 Macs, [Install UTM](https://mac.getutm.app/). To set up the vm, it similar to how it was set up in 42 B2Br project.

---
Make sure you have installed ufw and allowed certain ports
## **NGINX** (some key notes)
Dockerfile:
```Dockerfile
FROM debian:bullseye # pull debian image

RUN mkdir -p /path/to/html	# dir for mounting volumne
RUN mkdir -p /path/to/certs # dir for ssl certs and keys

COPY conf/global.conf /path/to/nginx/conf.d/	# configuration for nginx server block
COPY conf/nginx.conf /path/to/nginx/nginx.conf	# configuration for main, events, http blocks

EXPOSE 80 443 # configure
```
Build and Run:
```bash
# build image based on Dockerfile
sudo docker build . -t image-name:version

# -p 	map ports
# -d 	detached mode
# -v 	mount local dir to container dir
# nginx	command to run
sudo docker container run -d -p 8000:80 -p 8001:443 --name container-name -v local/dir:container/dir image-name:version nginx
```

