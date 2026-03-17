#!/usr/bin/env bash
set -e
source .env

DUMP_FILE="./data/hose_db.sql"
VOLUME_NAME="replica_db_data"

docker compose down -v
docker compose up -d db

echo "Waiting for database to accept connections..."
until docker exec hose-replica-db pg_isready -U "$POSTGRES_USER" -d "$POSTGRES_DB" > /dev/null 2>&1; do
  sleep 2
done

echo "Restoring data from dump file..."
docker exec -i hose-replica-db psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" < "$DUMP_FILE"

echo "Database replica ready"

echo
echo "You can connect to the replica database locally using:"
echo "-------------------------------------------"
echo "Host: localhost"
echo "Port: 5432"
echo "Database: $POSTGRES_DB"
echo "User: $POSTGRES_USER"
echo "Password: $POSTGRES_PASSWORD"
echo "-------------------------------------------"
echo "Example: psql -h localhost -U $POSTGRES_USER -d $POSTGRES_DB"