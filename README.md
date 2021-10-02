# docker-flask-supervisor-template

This repo contains:

* A minimal flask app
* wsgi.py file for gunicorn
* Rootless Dockerfile based on debian slim
* Configuration files for spuervisor (app and nginx)
* Minimal nginx configuration

To build and test:

docker build . -t flaskapp
docker run flaskapp -p8001:8001