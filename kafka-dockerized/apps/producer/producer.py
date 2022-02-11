import json
import os
from flask import Flask, request
from kafka import KafkaProducer

TOPIC_NAME = 'test2'
brokers_list = ['kafka-1:9092']
app = Flask(__name__)
producer = KafkaProducer(bootstrap_servers=brokers_list)


@app.route('/')
def hello_world():
    return 'Hello, World,  I am working!'


@app.route(f'/{TOPIC_NAME}')
def publish_name():
    name = request.args.get('name')
    data = {
        'name': name,
        'sender': 'service-producer-1'
    }
    jason_data = json.dumps(data)

    try:
        producer.send(TOPIC_NAME, jason_data.encode('utf-8'))
        producer.flush()
    except Exception as e:
        jason_data = json.dumps({"error": e})

    return jason_data


if __name__ == '__main__':
    port = int(os.environ.get('FLASK_PORT', 5000))
    app.run(debug=True, host='0.0.0.0', port=port)
