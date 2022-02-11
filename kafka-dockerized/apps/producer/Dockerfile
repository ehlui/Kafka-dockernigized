FROM python:3.8-alpine as dev-env

LABEL MAINTAINER="ehlui"

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENTRYPOINT [ "python" ]

CMD [ "producer.py" ]