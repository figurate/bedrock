#!/usr/bin/env python3

import os
from os.path import expanduser

import boto3


def init_path(path):
    os.makedirs(expanduser(f'~/.bedrock/{path}'), exist_ok=True)


def append_env(environment, env_var, warn_missing=False):
    if env_var in os.environ:
        environment.append(f'{env_var}={os.environ[env_var]}')
    elif warn_missing:
        print(f'** WARNING - Missing environment variable: {env_var}')


def assume_role(role_arn, role_session_name, role_duration):
    sts = boto3.client('sts')
    response = sts.assume_role(RoleArn=role_arn, RoleSessionName=role_session_name, DurationSeconds=role_duration)
    credentials = response['Credentials']

    os.putenv('AWS_ACCESS_KEY_ID', credentials['AccessKeyId'])
    os.putenv('AWS_SECRET_ACCESS_KEY', credentials['SecretAccessKey'])
    os.putenv('AWS_SESSION_TOKEN', credentials['SessionToken'])

