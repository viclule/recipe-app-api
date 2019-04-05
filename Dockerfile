FROM python:3.7-alpine
MAINTAINER Vicente Guerrero

# Recommended for python un docker images
ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
# permanent dependancies. allows psycopg2 to run
RUN apk add --update --no-cache postgresql-client
# permanent dependancies. required by Pillow
RUN apk add --update --no-cache jpeg-dev
# temporal packages before installing requirements.txt
# musl-dev zlib zlib-dev required by Pillow
RUN apk add --update --no-cache --virtual .tmp-build-deps \
        gcc libc-dev linux-headers postgresql-dev musl-dev zlib zlib-dev
RUN pip install -r /requirements.txt
run apk del .tmp-build-deps

# Setup directory structure. Applications will start from here
RUN mkdir /app
WORKDIR /app  
COPY ./app /app

RUN mkdir -p /vol/web/media  # -p make all the directories
RUN mkdir -p /vol/web/static
RUN adduser -D user  # User for running applications and process. For security purposes
RUN chown -R user:user /vol/
RUN chmod -R 755 /vol/web
USER user
