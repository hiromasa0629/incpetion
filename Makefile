COMPOSE_YML=./srcs/docker-compose.yml
WORDPRESS_SRCS=./srcs/requirements/wordpress/tools/srcs


all:
	mkdir -p $(WORDPRESS_SRCS)
	sudo docker compose -f $(COMPOSE_YML) up -d
down:
	sudo docker compose -f $(COMPOSE_YML) down

clean:
	sudo docker compose -f $(COMPOSE_YML) down	
	sudo docker rmi -f `sudo docker images -q`
	
fclean: clean
	rm -r $(WORDPRESS_SRCS)

re: clean all

.PHONY: all down clean fclean re
