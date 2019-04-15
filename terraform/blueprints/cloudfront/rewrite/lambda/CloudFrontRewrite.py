import re

def lambda_handler(event, context):
    request = event['Records'][0]['cf']['request']
    request.uri = re.sub(r"\+", "%2B", request.uri)
    return request
