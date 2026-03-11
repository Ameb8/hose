import requests

API_URL = "http://hose-api:8080"

def test_dest_all():
    '''
    Test GET request on /destinations endpoint
    '''
    r = requests.get(f"{API_URL}/destinations")
    assert r.status_code == 200
    data = r.json()
    assert data.get("status") == "ok"

def test_prop_by_id():
    '''
    Test GET by ID request for Property objects
    '''
    payload = {"name": "integration-test"}
    r = requests.post(f"{API_URL}/property/1", json=payload)
    assert r.status_code == 200
    data = r.json()
    assert data.get("status") == "ok"


