# Variable definitions
DOCKER_COMPOSE_FILE = setup/docker-compose.yml

.PHONY: help up down ps logs build restart

help:
	@echo " make up      - Start LocalStack environment"
	@echo " make down    - Stop and remove containers"
	@echo " make ps      - Show container status"
	@echo " make logs    - Show LocalStack logs (follow mode)"
	@echo " make build   - Build or rebuild services"
	@echo " make restart - Restart LocalStack containers"
	@echo ""

up:
	docker compose -f $(DOCKER_COMPOSE_FILE) up -d

down:
	docker compose -f $(DOCKER_COMPOSE_FILE) down

ps:
	docker compose -f $(DOCKER_COMPOSE_FILE) ps

logs:
	docker compose -f $(DOCKER_COMPOSE_FILE) logs -f

build:
	docker compose -f $(DOCKER_COMPOSE_FILE) build

restart:
	docker compose -f $(DOCKER_COMPOSE_FILE) restart
