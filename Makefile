COMPOSE_YML=./srcs/docker-compose.yml
WORDPRESS_SRCS=./srcs/requirements/wordpress/tools/srcs
IMAGES_COUNT=$(shell sudo docker images -q | wc -l;)

all:
	mkdir -p $(WORDPRESS_SRCS)
	sudo docker compose -f $(COMPOSE_YML) up -d
down:
	sudo docker compose -f $(COMPOSE_YML) down

clean:
	sudo docker compose -f $(COMPOSE_YML) down
ifneq ($(IMAGES_COUNT),0)
	sudo docker rmi -f `sudo docker images -q`
endif
	
fclean: clean
	sudo rm -rf $(WORDPRESS_SRCS)

re: clean all

.PHONY: all down clean fclean re
