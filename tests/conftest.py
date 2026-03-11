import pytest
import requests
import time

API_URL: str = "http://hose-api:8080"
START_WAIT_TIME: int = 60

@pytest.fixture(scope="session", autouse=True)
def wait_for_api():
    """Wait until hose-api is ready before running any tests."""
    for _ in range(START_WAIT_TIME):
        try:
            r = requests.get(f"{API_URL}/destinations")
            if r.status_code == 200:
                print("API is healthy!")
                return
        except requests.ConnectionError:
            pass
        time.sleep(1)
    raise RuntimeError("hose-api did not become healthy in time")