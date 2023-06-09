FROM --platform=linux/amd64 python:3.11-slim-bullseye

WORKDIR /app

ADD requirements.txt /app/requirements.txt
RUN pip install -r requirements.txt

ADD app.py /app/app.py

EXPOSE 80

CMD ["python3", "app.py"]
