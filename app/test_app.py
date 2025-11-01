import json; from app import app
def test_healthz():
    c = app.test_client(); r = c.get('/healthz'); assert r.status_code==200; d=json.loads(r.data.decode()); assert d.get("status")=="ok"
