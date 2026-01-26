#!/usr/bin/env bash

# Exit immediately on error
set -euo pipefail

# Get path to project root directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"

# Load env vars
set -o allexport
source "${PROJECT_ROOT}/.env"
set +o allexport

# Container name
POSTGRES_CONTAINER="my_postgres"

# DB config
DB_NAME="${DB_NAME:-hose_db}"
DB_USER="${DB_USER:-username}"

# Construct path to dump location (hose/database/dumps)
DUMP_DIR="${PROJECT_ROOT}/database/dumps"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
DUMP_FILE="${DUMP_DIR}/data_dump_${TIMESTAMP}.sql"

# Tables included in dump file
TABLES=(
  addresses
  destinations
  properties
  unit_types
  property_walk_distances
  property_images
  lease_agreements
  pet_policies
  lease_rules
  pet_rules
  lease_agreement_rules
  property_pet_rules
)

# Convert TABLES string into -t args
TABLE_ARGS=()
for tbl in ${TABLES}; do
  TABLE_ARGS+=( "-t" "${tbl}" )
done

# Ensure dump directory exists
mkdir -p "${DUMP_DIR}"

# Inform user dump is beginning
echo "Dumping data to ${DUMP_FILE} ..."
echo "Database: ${DB_NAME}"
echo "Tables: ${TABLES}"

# Execute data dump
docker exec "${POSTGRES_CONTAINER}" pg_dump \
  -U "${DB_USER}" \
  --dbname="${DB_NAME}" \
  --data-only \
  --column-inserts \
  --exclude-table=flyway_schema_history \
  "${TABLE_ARGS[@]}" \
  > "${DUMP_FILE}"

echo "Data dump saved to: ${DUMP_FILE}"
