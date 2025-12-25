# ==============================================================================
# Docker
# ==============================================================================

DOCKER_COMPOSE := docker compose -f infra/docker/docker-compose.yml

docker-build: ## Build Docker images
	$(DOCKER_COMPOSE) build

docker-build-nc: ## Build Docker images (no cache)
	$(DOCKER_COMPOSE) build --no-cache

docker-up: ## Start Docker containers
	$(DOCKER_COMPOSE) up -d

docker-down: ## Stop Docker containers
	$(DOCKER_COMPOSE) down

docker-restart: docker-down docker-up ## Restart Docker containers

docker-logs: ## View Docker container logs
	$(DOCKER_COMPOSE) logs -f

docker-logs-api: ## View API container logs
	$(DOCKER_COMPOSE) logs -f api

docker-logs-worker: ## View worker container logs
	$(DOCKER_COMPOSE) logs -f worker

docker-shell-api: ## Open shell in API container
	$(DOCKER_COMPOSE) exec api sh

docker-ps: ## Show running Docker containers
	$(DOCKER_COMPOSE) ps

docker-shell: ## Open shell in main container
	$(DOCKER_COMPOSE) exec api sh

docker-clean: ## Stop containers and remove volumes
	$(DOCKER_COMPOSE) down -v --remove-orphans

docker-prune: ## Remove all unused Docker resources
	docker system prune -af

docker-build-prod: ## Build production Docker image
	docker build -f infra/docker/Dockerfile -t monorepo-api:latest .

docker-run-prod: ## Run production Docker container
	docker run -p 8000:8000 --env-file .env monorepo-api:latest
