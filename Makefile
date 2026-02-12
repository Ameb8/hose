# Docker compose files
COMPOSE=docker compose
BASE_FILE=-f docker-compose.yml
DEV_FILE=-f docker-compose.dev.yml
PROD_FILE=-f docker-compose.prod.yml

.PHONY: dev prod build down logs restart

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

# Restart services
restart:
	$(COMPOSE) $(BASE_FILE) restart
