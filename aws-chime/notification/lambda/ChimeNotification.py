import os

import requests

webhook_url = os.environ['WebhookUrl']


def lambda_handler(event, context):
    notify(webhook_url, get_message(event))


def get_message(event):
    if 'Records' in event:
        return event['Records'][0]['Sns']['Subject']

    return event['Message']


def notify(url, content):
    print(f"Publishing notification: {content}")
    requests.post(url=url, json={'Content': content})
