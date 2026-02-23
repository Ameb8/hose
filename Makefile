# Docker compose files
COMPOSE=docker compose
BASE_FILE=-f docker-compose.yml
DEV_FILE=-f docker-compose.dev.yml
PROD_FILE=-f docker-compose.prod.yml

.PHONY: dev dev-build prod build down logs logs-dev logs-build restart osrm

# Run in development config
dev:
	$(COMPOSE) $(BASE_FILE) $(DEV_FILE) up --build

# Build and run development config
dev-build:
	$(COMPOSE) $(BASE_FILE) $(DEV_FILE) up --build

# Run in production config
prod:
	$(COMPOSE) $(BASE_FILE) $(PROD_FILE) up --build -d

# Build containers
build:
	$(COMPOSE) $(BASE_FILE) build

# Stop containers
down:
	$(COMPOSE) $(BASE_FILE) down

# View logs
logs:
	$(COMPOSE) $(BASE_FILE) logs -f

# View development logs
logs-dev:
	$(COMPOSE) $(BASE_FILE) $(DEV_FILE) logs -f

# View production logs
logs-prod:
	$(COMPOSE) $(BASE_FILE) $(PROD_FILE) logs -f

# Safely rebuild and restart only the webpage in prod
deploy-frontend:
	$(COMPOSE) $(BASE_FILE) $(PROD_FILE) build hose-frontend
	$(COMPOSE) $(BASE_FILE) $(PROD_FILE) up -d --no-deps hose-frontend

# Safely rebuild and restart only the Rest-API in prod
deploy-api:
	$(COMPOSE) $(BASE_FILE) $(PROD_FILE) build hose-api
	$(COMPOSE) $(BASE_FILE) $(PROD_FILE) up -d --no-deps hose-api

osrm:
	$(COMPOSE) $(BASE_FILE) $(DEV_FILE) up -d osrm

# Restart services
restart:
	$(COMPOSE) $(BASE_FILE) restart
