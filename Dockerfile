FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install gunicorn

COPY . .

# N-sawabou script bach n-khaddmou kolchi f deqqa
RUN echo "#!/bin/bash \n\
celery -A worker.celery worker --loglevel=info --pool=solo & \n\
gunicorn --bind 0.0.0.0:\$PORT app:app" > start.sh

RUN chmod +x start.sh

CMD ["./start.sh"]