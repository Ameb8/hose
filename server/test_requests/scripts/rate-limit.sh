#!/bin/bash

URL="https://precisely-cave-inexpensive-cardiovascular.trycloudflare.com/destinations"

echo "Sending 10 requests..."
for i in {1..10}; do
    STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$URL")
    echo "Request $i: HTTP $STATUS"
done
