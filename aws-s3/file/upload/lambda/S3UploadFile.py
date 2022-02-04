import boto3
import json
import os

s3_bucket = os.environ['S3Bucket']


def lambda_handler(event):
    filename = event['filename']
    filetype = event['filetype']
    presigned_url = generate_presigned_post(filename, filetype)

    return json.dumps({
        'data': presigned_url,
        'url': 'https://%s.s3.amazonaws.com/%s' % (s3_bucket, filename)
    })


def generate_presigned_post(filename, filetype):
    s3 = boto3.client('s3')

    return s3.generate_presigned_post(
        Bucket=s3_bucket,
        Key=filename,
        Fields={"acl": "public-read", "Content-Type": filetype},
        Conditions=[
            {"acl": "public-read"},
            {"Content-Type": filetype}
        ],
        ExpiresIn=3600
    )
