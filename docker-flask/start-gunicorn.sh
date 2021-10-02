#!/bin/bash

/opt/venv/bin/activate && cd /app && /opt/venv/bin/gunicorn --worker-class gevent flask_app:app --log-level info --chdir ./ --bind unix:/app/app.sock 
