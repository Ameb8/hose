import os
import sys
import json
import time
import requests
from pathlib import Path
from dotenv import load_dotenv

# Load .env
SCRIPT_DIR = Path(__file__).resolve().parent
load_dotenv(SCRIPT_DIR / "../../../.env")

BASE_URL = os.getenv("SERVER_URL")
API_URL = f"{BASE_URL}/properties"
API_KEY = os.getenv("ADMIN_KEY")

if not API_KEY:
    print("ERROR: ADMIN_KEY not found in environment.")
    sys.exit(1)

if len(sys.argv) != 2:
    print("Usage: python bulk_upload.py data.json")
    sys.exit(1)

data_file = sys.argv[1]

with open(data_file, "r") as f:
    payload = json.load(f)

properties = payload.get("properties", [])

for index, property_obj in enumerate(properties, start=1):
    print(f"\nSubmitting property {index}/{len(properties)}: {property_obj.get('name')}")

    try:
        response = requests.post(
            API_URL,
            headers={
                "Content-Type": "application/json",
                "Accept": "application/json",
                "x-api-key": API_KEY,
            },
            json=property_obj,
            timeout=30,
        )

        print(f"Status Code: {response.status_code}")
        print("Response Body:")
        print(response.text)

    except requests.RequestException as e:
        print("Request failed:", str(e))

    # Wait 10 seconds before next request
    if index < len(properties):
        print("Waiting 10 seconds before next request...")
        time.sleep(10)

print("\nDone.")