FROM python:3.7-alpine
MAINTAINER Vicente Guerrero

# Recommended for python un docker images
ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

# Setup directory structure. Applications will start from here
RUN mkdir /app
WORKDIR /app  
COPY ./app /app

RUN adduser -D user  # User for running applications and process. For security purposes
USER user



