from datetime import datetime, timezone

import boto3
from botocore.exceptions import ClientError


def lambda_handler(event, context):
    user_ids = get_user_ids(event)

    for userid in user_ids:
        rotate_access_keys(userid, 90)


def get_user_ids(event):
    if 'UserId' in event:
        return [event['UserId']]

    iam = boto3.client('iam')

    if 'Group' in event:
        result = iam.get_group(GroupName=event['Group'])
        return list(map(lambda i: i['UserId'], result['Users']))

    try:
        lambda_config = iam.get_function_configuration(
            FunctionName='IamKeyRotation'
        )
        return [lambda_config['Environment']['Variables']['UserId']]
    except ClientError as e:
        print(e)


def rotate_access_keys(userid, max_age):
    iam = boto3.client('iam')

    access_keys = iam.list_access_keys(UserName=userid)

    for key in access_keys['AccessKeyMetadata']:
        if key['Status'] == 'Inactive':
            # If key already inactive delete it..
            iam.delete_access_key(UserName=userid, AccessKeyId=key['AccessKeyId'])
        elif (datetime.now(timezone.utc) - key['CreateDate']).days > max_age:
            # Disable active keys older than max_age..
            iam.update_access_key(UserName=userid, AccessKeyId=key['AccessKeyId'], Status='Inactive')
            # new_access_key = iam.create_access_key(UserName=userid)
