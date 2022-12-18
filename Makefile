PROJECT ?= docker-test-env
DOCKER_COMPOSE_FILE ?= docker-compose.yml

DOCKER_COMPOSE_ARGS ?= -p $(PROJECT) -f $(DOCKER_COMPOSE_FILE)

SHELL := /bin/bash

run: help

BOLD ?= $(shell tput bold)
NORMAL ?= $(shell tput sgr0)

help:
	@echo SSH into container:
	@echo "  ${BOLD}make ssh${NORMAL}"
	@echo ""

services-bash:
	docker exec -it $(shell make services-id) /bin/bash

services-ps:
	docker-compose $(DOCKER_COMPOSE_ARGS) ps

services-up:
	docker-compose $(DOCKER_COMPOSE_ARGS) up -d

services-build:
	docker-compose $(DOCKER_COMPOSE_ARGS) build

services-down:
	docker-compose $(DOCKER_COMPOSE_ARGS) stop

services-destroy:
	docker-compose $(DOCKER_COMPOSE_ARGS) down --volumes

services-logs:
	docker-compose $(DOCKER_COMPOSE_ARGS) logs -f

services-id:
	@set -o pipefail; \
	docker-compose $(DOCKER_COMPOSE_ARGS) ps -q | head -n 1

services-name:
	@set -o pipefail; \
	docker-compose $(DOCKER_COMPOSE_ARGS) ps -q | head -n 1 | xargs docker inspect --format '{{ .Name }}' | sed 's/^\///'
