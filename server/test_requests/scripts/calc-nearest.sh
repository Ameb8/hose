#!/usr/bin/env bash


# Get script dir
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source API-Key from .env
export $(grep -v '^#' "$SCRIPT_DIR/../../../.env" | xargs)

curl -X PATCH "$SERVER_URL/properties/stops/$1" \
  -H "X-API-Key: $ADMIN_KEY" \
  -H "Content-Type: application/json" \
