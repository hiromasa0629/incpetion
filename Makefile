COMPOSE_YML=./srcs/docker-compose.yml
WORDPRESS_SRCS=/home/hyap/data/wordpress
MARIADB_SRCS=/home/hyap/data/wordpressdb
VOLUME_COUNT=$(shell sudo docker volume ls -q | wc -l;)

all:
	sudo mkdir -p ${WORDPRESS_SRCS}
	sudo mkdir -p ${MARIADB_SRCS}
	sudo ROOT_PWD=${PWD} docker compose -f $(COMPOSE_YML) --verbose up -d
down:
	sudo ROOT_PWD=${PWD} docker compose -f $(COMPOSE_YML) down

clean: down
	sudo docker image prune -a -f
	sudo docker volume prune -f
ifneq ($(VOLUME_COUNT), 0)
	sudo docker volume rm `sudo docker volume ls -q`
endif
	sudo docker network prune -f

fclean: clean
	sudo rm -rf $(WORDPRESS_SRCS)
	sudo rm -rf ${MARIADB_SRCS}
	sudo docker system prune -a -f

re: fclean all

.PHONY: all down clean fclean re
