import csv

import boto3
from botocore.exceptions import ClientError

data_types = {'Debit': 'N', 'Credit': 'N', 'Balance': 'N'}


def lambda_handler(event, context):
    bucket = event['Records'][0]['s3']['bucket']['name']
    filename = event['Records'][0]['s3']['object']['key']

    import_file(bucket, filename)


def import_file(bucket, filename):
    s3 = boto3.client('s3')
    dynamodb = boto3.client('dynamodb')
    try:
        data = s3.get_object(Bucket=bucket, Key=filename)['Body'].read().decode('utf-8')
        csv_reader = csv.reader(data.splitlines(), delimiter=',')
        columns = None
        linenum = 0
        for row in csv_reader:
            if linenum == 0:
                columns = row
            else:
                import_row(row2map(columns, row), dynamodb)
            linenum += 1
    except ClientError as e:
        print(e)


def row2map(columns, row):
    retval = {}
    for column in columns:
        if len(row[columns.index(column)]) > 0:
            data_type = data_types[column] if column in data_types else 'S'
            retval[column] = {data_type: row[columns.index(column)]}
    return retval


def import_row(row, client):
    try:
        client.put_item(
            TableName='finance-ing_com_au',
            Item=row
        )
    except ClientError as e:
        print(e)
