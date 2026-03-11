import os
import sys
import time
import re
import requests
from pathlib import Path
from dotenv import load_dotenv

# Load .env
SCRIPT_DIR = Path(__file__).resolve().parent
load_dotenv(SCRIPT_DIR / "../../../.env")

# Configuration
API_KEY = os.getenv("ADMIN_KEY")
BASE_URL = os.getenv("SERVER_URL")
DELAY_SECONDS = 10

IMAGE_EXTENSIONS = {'.jpg', '.jpeg', '.png', '.gif', '.webp', '.bmp', '.tiff'}

def upload_image(property_id: int, image_path: str) -> bool:
    url = f"{BASE_URL}/properties/{property_id}/images"
    
    with open(image_path, 'rb') as f:
        files = {'file': f}
        data = {'isThumbnail': 'true'}
        headers = {'x-api-key': API_KEY, 'Accept': 'application/json'}
        
        response = requests.post(url, headers=headers, files=files, data=data)
    
    filename = os.path.basename(image_path)
    status = response.status_code

    try:
        body = response.json()
        import json
        body_str = json.dumps(body, indent=2)
    except Exception:
        body_str = response.text or "(empty)"

    print(f"  [{status}] {filename}")
    print(f"  {body_str}\n")

    return response.ok


def process_directory(root_dir: str):
    if not os.path.isdir(root_dir):
        print(f"Error: '{root_dir}' is not a valid directory.")
        sys.exit(1)

    # Find all subdirs matching *_<int>
    subdirs = []
    for entry in os.scandir(root_dir):
        if entry.is_dir():
            match = re.search(r'_(\d+)$', entry.name)
            if match:
                property_id = int(match.group(1))
                subdirs.append((property_id, entry.path))

    if not subdirs:
        print("No matching subdirectories found (expected format: *_<int>).")
        return

    subdirs.sort(key=lambda x: x[0])
    print(f"Found {len(subdirs)} matching subdirectory/ies.\n")

    first_upload = True

    for property_id, subdir_path in subdirs:
        images = sorted([
            os.path.join(subdir_path, f)
            for f in os.listdir(subdir_path)
            if os.path.splitext(f)[1].lower() in IMAGE_EXTENSIONS
        ])

        if not images:
            print(f"Skipping '{subdir_path}' — no images found.")
            continue

        print(f"Property {property_id} ({os.path.basename(subdir_path)}): {len(images)} image(s)")

        for image_path in images:
            if not first_upload:
                print(f"  Waiting {DELAY_SECONDS}s...")
                time.sleep(DELAY_SECONDS)
            first_upload = False

            upload_image(property_id, image_path)

    print("\nDone.")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print(f"Usage: python {sys.argv[0]} <directory>")
        sys.exit(1)

    process_directory(sys.argv[1])