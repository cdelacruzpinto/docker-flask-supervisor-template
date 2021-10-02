FROM python:3.7.11-slim
RUN mkdir /app
RUN /usr/local/bin/python -m venv /opt/venv 
RUN /usr/local/bin/python -v
WORKDIR /app
COPY flask_app.py /app/flask_app.py
COPY requirements.txt /app/requirements.txt
COPY start-gunicorn.sh /app/start-gunicorn.sh
RUN apt-get update && apt-get install -y supervisor nginx
RUN chmod 755 /opt/venv/bin/activate
RUN . /opt/venv/bin/activate && pip install -r requirements.txt
RUN . /opt/venv/bin/activate && pip install gunicorn[gevent]
#CMD . /opt/venv/bin/activate && cd /app && gunicorn --worker-class gevent flask_app:app --log-level info
RUN echo "files = /etc/supervisor/conf.d/*.ini" >> /etc/supervisor/supervisord.conf 
# copy gunicorn + gevent script 
ADD start-gunicorn.sh /app/start-gunicorn.sh
RUN groupadd alice
RUN useradd alice -g alice
RUN chown -R alice:alice /app
RUN chown -R alice:alice /var/log/nginx
RUN chown -R alice:alice /var/lib/nginx


RUN chown -R alice:alice /run

RUN chown -R alice:alice /var/log/supervisor

# nginx conf + supervisord conf
ADD nginx.conf /etc/nginx/conf.d/flask-app.conf
ADD supervisor.ini /etc/supervisor/conf.d/gunicorn.ini
ADD nginx.ini /etc/supervisor/conf.d/nginx.ini
USER alice:alice

# to expose port 8001
EXPOSE 8001

# start supervisord
CMD ["supervisord", "--nodaemon", "-c", "/etc/supervisor/supervisord.conf"]
