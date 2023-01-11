COMPOSE_YML=./srcs/docker-compose.yml
WORDPRESS_SRCS=./srcs/requirements/wordpress/tools/srcs
MARIADB_SRCS=./srcs/requirements/mariadb/tools/srcs

all:
	mkdir -p $(WORDPRESS_SRCS)
	mkdir -p $(MARIADB_SRCS)
	sudo ROOT_PWD=${PWD} docker compose -f $(COMPOSE_YML) --verbose up -d
down:
	sudo ROOT_PWD=${PWD} docker compose -f $(COMPOSE_YML) down

clean: down
	sudo docker network prune -f
	sudo docker volume prune -f
	sudo docker image prune -a -f

fclean: clean
	sudo rm -rf $(WORDPRESS_SRCS)
	sudo docker system prune -a -f

re: clean all

.PHONY: all down clean fclean re
