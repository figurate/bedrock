#!/usr/bin/env python3

"""
Support for provisioning blueprint constellations via a provided manifest.

Usage: bedrock [-m <manifest_file>] <apply|destroy>

e.g.

* bedrock example.yml apply
* bedrock destroy # use file "manifest.yml" in current directory
"""
import os
from os.path import expanduser

import docker
import sys
import yaml

try:
    from yaml import CLoader as Loader
except ImportError:
    from yaml import Loader


def init_path(path):
    os.makedirs(expanduser(f'~/.bedrock/{path}'), exist_ok=True)


def parse_manifest(path):
    return yaml.load(open(path, 'r'), Loader=Loader)


def apply_blueprint(name, key, config, action):
    print(f'Apply blueprint: {name}/{key} [{action}]')

    init_path(f'{name}/{key}')

    client = docker.from_env()
    environment = [
        f'TF_BACKEND_KEY={name}/{key}',
        f'TF_APPLY_ARGS=-auto-approve',
        f'AWS_ACCESS_KEY_ID={os.environ["AWS_ACCESS_KEY_ID"]}',
        f'AWS_SECRET_ACCESS_KEY={os.environ["AWS_SECRET_ACCESS_KEY"]}',
        f'TF_VAR_region={os.environ["AWS_DEFAULT_REGION"]}',
        f'http_proxy={os.environ["http_proxy"]}',
        f'https_proxy={os.environ["https_proxy"]}',
        f'no_proxy={os.environ["no_proxy"]}'
    ]

    if config:
        for item in config:
            if isinstance(config[item], list):
                config_string = '["%s"]' % '","'.join(config[item])
                environment.append(f'TF_VAR_{item}={config_string}')
            else:
                environment.append(f'TF_VAR_{item}={config[item]}')

    volumes = {
        expanduser(f'~/.bedrock/{name}/{key}'): {
            'bind': '/work',
            'mode': 'rw'
        }
    }
    container = client.containers.run(f"bedrock/{name}", action, privileged=True, network_mode='host',
                          remove=True, environment=environment, volumes=volumes, tty=True, detach=True)
    logs = container.logs(stream=True)
    for log in logs:
        print(log.decode('utf-8'), end='')


manifest = sys.argv[1]
blueprint_action = sys.argv[2]
manifest = parse_manifest(manifest)

for constellation in manifest['constellations']:
    blueprint_key = constellation
    for blueprint in manifest['constellations'][constellation]:
        apply_blueprint(blueprint, blueprint_key, manifest['constellations'][constellation][blueprint],
                        blueprint_action)
