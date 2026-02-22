#!/usr/bin/env bash
set -e

echo "Calculating wal time/distance from North Village Cafe to Samuelson Hall with OSRM"
echo "Google Maps benchmark result: ~16 minutes / ~0.8 miles"
echo "In OSRM units: ~960 seconds / ~1287.5 meters"

echo "OSRM results:"

curl "http://localhost:5003/route/v1/driving/-120.53364,47.00873;-120.53970,47.00128?overview=false"