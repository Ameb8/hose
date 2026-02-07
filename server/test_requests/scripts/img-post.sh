#!/bin/bash


# Get parameters from command line
PROPERTY_ID="$1" # Property PPK
IMAGE_PATH="$2" # Path to image fle

# Check if parameters are provided
if [ -z "$PROPERTY_ID" ] || [ -z "$IMAGE_PATH" ]; then
  echo "Usage: $0 <property_id> <image_path>"
  exit 1
fi

# Make the PropertyImage POST request
curl -v -X POST "http://localhost:8080/properties/$PROPERTY_ID/images" \
  -H "Accept: application/json" \
  -F "file=@$IMAGE_PATH" \
  -F "isThumbnail=true"
