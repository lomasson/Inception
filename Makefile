SRC = srcs/docker-compose.yml 
DOCKER=$(shell docker ps -a -q)
IMAGES=$(shell docker images -a -q)
VOLUMES=$(shell docker volume ls -q)
NETWORKS=$(shell docker network ls -q)

all: run

re : clean build

logs:
	docker-compose -f ${SRC} logs -f -t
run :   
	grep lomasson.42.fr /etc/hosts > /dev/null || sed '/127.0.0.1[\t ]*localhost/a\127.0.0.1       lomasson.42.fr' -i /etc/hosts
	grep www.lomasson.42.fr /etc/hosts /dev/null || sed '/127.0.0.1[\t ]*lomasson.42.fr/a\127.0.0.1       www.lomasson.42.fr' -i /etc/hosts
	mkdir -p /home/lomasson/data/data
	mkdir -p /home/lomasson/data/app
	docker-compose -f ${SRC} up
down :
	docker-compose -f ${SRC} down
stop :
	docker-compose -f ${SRC} stop
build :
	docker-compose -f ${SRC} build

clean : down 
	@test -z $(VOLUMES) ||  docker volume rm -f $(VOLUMES)
	@test -z $(DOCKER) || docker rm -f $(DOCKER)
	rm -rf /home/lomasson/data

fclean : down
	@test -z $(DOCKER) || docker rm -f $(DOCKER)
	docker system prune -a -f
	@test -z $(IMAGES) || docker rmi -f $(IMAGES)
	@test -z $(VOLUMES) || docker volume rm -f $(VOLUMES)
	rm -rf /home/lomasson/data/* 
	@test -z $(NETWORKS) || docker network rm -f $(NETWORKS) 2>/dev/null

.PHONY: up down stop build clean flcean all logs
