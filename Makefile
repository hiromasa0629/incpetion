COMPOSE_YML=./srcs/docker-compose.yml
WORDPRESS_SRCS=./srcs/requirements/wordpress/tools/srcs

all:
	mkdir -p $(WORDPRESS_SRCS)
	sudo ROOT_PWD=${PWD} docker compose -f $(COMPOSE_YML) up -d
down:
	sudo ROOT_PWD=${PWD} docker compose -f $(COMPOSE_YML) down

clean: down
	sudo docker network prune -f
	sudo docker volume prune -f
	sudo docker image prune -a -f

fclean: clean
	sudo rm -rf $(WORDPRESS_SRCS)

re: clean all

.PHONY: all down clean fclean re
