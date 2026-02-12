#!/bin/bash


# Get script dir
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source API-Key from .env
export $(grep -v '^#' "$SCRIPT_DIR/../../../.env" | xargs)


DATA_FILE="$1"

# Make POST request for properties/
curl -v -X POST "https://precisely-cave-inexpensive-cardiovascular.trycloudflare.com/properties" \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -H "x-api-key: $ADMIN_KEY" \
  --data @"$DATA_FILE"
