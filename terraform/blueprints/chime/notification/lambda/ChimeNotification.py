import boto3
import requests
from botocore.exceptions import ClientError


webhook_url = None

lambdac = boto3.client('lambda')
try:
    config = lambdac.get_function_configuration(FunctionName='ChimeNotification')
    webhook_url = config['Environment']['Variables']['WebhookUrl']
except ClientError as e:
    print(e)


def lambda_handler(event, context):
    notify(webhook_url, get_message(event))


def get_message(event):
    if 'Records' in event:
        return event['Records'][0]['Sns']['Subject']

    return event['Message']


def notify(url, content):
    print(f"Publishing notification: {content}")
    requests.post(url=url, json={'Content': content})
