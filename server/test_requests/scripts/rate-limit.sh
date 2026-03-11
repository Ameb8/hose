#!/usr/bin/env bash


# Get script dir
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source API-Key from .env
export $(grep -v '^#' "$SCRIPT_DIR/../../../.env" | xargs)


URL="$SERVER_URL/destinations"

echo "Sending 20 requests..."
for i in {1..20}; do
    STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$URL")
    echo "Request $i: HTTP $STATUS"
done
