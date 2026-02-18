#!/usr/bin/env bash
set -e

# Resolve the path of this file
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DATA_DIR="$SCRIPT_DIR/../data"

echo "Preprocessing OSM data in $DATA_DIR ..."

docker run --rm -v "$DATA_DIR":/data osrm-backend-arm sh -c "\
  osrm-extract -p /data/foot.lua /data/ellensburg.osm.pbf && \
  osrm-partition /data/ellensburg.osrm && \
  osrm-customize /data/ellensburg.osrm"

echo "Processed .osrm files created in $DATA_DIR"
