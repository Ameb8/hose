#!/bin/bash


# Get parameters from command line
PROPERTY_ID="$1" # Property PPK
IMAGE_PATH="$2" # Path to image fle

# Check if parameters are provided
if [ -z "$PROPERTY_ID" ] || [ -z "$IMAGE_PATH" ]; then
  echo "Usage: $0 <property_id> <image_path>"
  exit 1
fi

# Get script dir
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source API-Key from .env
export $(grep -v '^#' "$SCRIPT_DIR/../../../.env" | xargs)



# Make the PropertyImage POST request
curl -v -X POST "https://precisely-cave-inexpensive-cardiovascular.trycloudflare.com/properties/$PROPERTY_ID/images" \
  -H "Accept: application/json" \
  -F "file=@$IMAGE_PATH" \
  -H "x-api-key: $ADMIN_KEY" \
  -F "isThumbnail=true"
