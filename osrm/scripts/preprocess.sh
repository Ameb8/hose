#!/usr/bin/env bash
set -e

if [ -z "$1" ]; then
  echo "Usage: $0 {foot|bike|car}"
  exit 1
fi

PROFILE_NAME="$1"

# Map profile names to OSRM lua files
case "$PROFILE_NAME" in
  foot)
    LUA_PROFILE="/opt/foot.lua"
    ;;
  bike)
    LUA_PROFILE="/opt/bicycle.lua"
    ;;
  car)
    LUA_PROFILE="/opt/car.lua"
    ;;
  *)
    echo "Invalid profile: $PROFILE_NAME"
    echo "Valid options: foot | bike | car"
    exit 1
    ;;
esac

# Resolve paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DATA_DIR="$SCRIPT_DIR/../data"
PBF_FILE="$DATA_DIR/ellensburg.osm.pbf"
OUTPUT_DIR="$DATA_DIR/$PROFILE_NAME"

mkdir -p "$OUTPUT_DIR"

echo "Preprocessing profile: $PROFILE_NAME"
echo "Using Lua profile: $LUA_PROFILE"
echo "Output directory: $OUTPUT_DIR"

docker run --rm -v "$DATA_DIR":/data osrm-backend-arm sh -c "\
  cd /data/$PROFILE_NAME && \
  osrm-extract -p $LUA_PROFILE ellensburg.osm.pbf && \
  osrm-partition ellensburg.osrm && \
  osrm-customize ellensburg.osrm \
"

echo "Done: Files created in $OUTPUT_DIR"
