SRC = ./srcs/docker-compose.yml

all : 
	@echo "Launching configuration\n"
	@sudo docker-compose -f $(SRC) up -d

build :
	@echo "Building configuration\n"
	@sudo mkdir -p /home/gabtan/data/mariadb
	@sudo mkdir -p /home/gabtan/data/wordpress
	@sudo docker-compose -f $(SRC) up -d

down :
	@echo "Stopping configuration\n"
	@sudo docker-compose -f $(SRC) down -v

clean: down
	@echo "Cleaning configuration - all unused containers, networks and images\n"
	@sudo docker system prune -af

fclean: clean
	@echo "Cleaning configuration - delete containers, networks, volumes, images and directories\n"
	@sudo rm -rf /home/gabtan/data/mariadb
	@sudo rm -rf /home/gabtan/data/wordpress
	@sudo docker network prune --force
	@sudo docker volume prune --force
	@sudo docker system prune --all --force --volumes

re: clean build

.PHONY: all build down clean fclean re
