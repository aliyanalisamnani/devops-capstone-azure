from flask import Flask, jsonify
import os
app = Flask(__name__)
@app.get("/")
def root(): return jsonify(app="devops-capstone", message="Hello from Flask on Kubernetes!")
@app.get("/healthz")
def health(): return jsonify(status="ok")
if __name__ == "__main__": app.run(host="0.0.0.0", port=int(os.environ.get("PORT", 8080)))
