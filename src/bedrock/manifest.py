#!/usr/bin/env python3

"""
Support for provisioning blueprint constellations via a provided manifest.

Usage: manifest [-m <manifest_file>] <apply|destroy>

e.g.

* manifest example.yml apply
* manifest destroy # use file "manifest.yml" in current directory
"""
import argparse
import os
from os.path import expanduser

import docker
import yaml

try:
    from yaml import CLoader as Loader
except ImportError:
    from yaml import Loader


def init_path(path):
    os.makedirs(expanduser(f'~/.bedrock/{path}'), exist_ok=True)


def parse_manifest(file):
    return yaml.load(file, Loader=Loader)


def merge_config(manifest_vars, cli_config):
    configvars = {}

    if cli_config is not None:
        for cnf in cli_config:
            cargs = cnf.split('=')
            configvars[cargs[0]] = cargs[1]

    for var in manifest_vars:
        if var not in configvars:
            if 'default' in manifest_vars[var]:
                configvars[var] = manifest_vars[var]['default']
            else:
                raise ValueError(f'Missing value for mandatory variable: {var}')
                
    return configvars


def resolve_key(parts, varlist, default_key):
    varmap = dict(map(lambda var: var.split('='), varlist))
    keyparts = [key for key in (map(lambda part: varmap[part] if part in varmap else None, parts) if parts else None) if key is not None]
    return f'{"-".join(keyparts + [default_key])}' if keyparts else default_key


def append_env(environment, env_var):
    if env_var in os.environ:
        environment.append(f'{env_var}={os.environ[env_var]}')


def apply_blueprint(name, key, config, action, extra_volumes, extra_config):
    print(f'Apply blueprint: {name}/{key} [{action}]')

    init_path(f'{name}/{key}')

    client = docker.from_env()
    environment = [
        f'TF_BACKEND_KEY={name}/{key}',
        f'AWS_ACCESS_KEY_ID={os.environ["AWS_ACCESS_KEY_ID"]}',
        f'AWS_SECRET_ACCESS_KEY={os.environ["AWS_SECRET_ACCESS_KEY"]}',
        f'AWS_DEFAULT_REGION={os.environ["AWS_DEFAULT_REGION"]}',
    ]

    # Append optional environment variables..
    for env_var in ['AWS_SESSION_TOKEN', 'TF_STATE_BUCKET', 'TF_ARGS', 'http_proxy', 'https_proxy', 'no_proxy']:
        append_env(environment, env_var)

    # Append openstack environment variables..
    for env_var in ['OS_AUTH_URL', 'OS_TENANT_ID', 'OS_TENANT_NAME', 'OS_USERNAME', 'OS_PASSWORD', 'OS_REGION_NAME',
                    'OS_ENDPOINT_TYPE', 'OS_IDENTITY_API_VERSION']:
        append_env(environment, env_var)

    # Append digitalocean environment variables..
    for env_var in ['DIGITALOCEAN_TOKEN', 'SPACES_ACCESS_KEY_ID', 'SPACES_SECRET_ACCESS_KEY']:
        append_env(environment, env_var)

    # Append rancher environment variables..
    for env_var in ['RANCHER_URL', 'RANCHER_ACCESS_KEY', 'RANCHER_SECRET_KEY']:
        append_env(environment, env_var)

    if config:
        for item in config:
            if isinstance(config[item], list):
                config_string = '["%s"]' % '","'.join(config[item])
                environment.append(f'TF_VAR_{item}={config_string}')
            else:
                environment.append(f'TF_VAR_{item}={config[item]}')

    print(extra_config)

    if extra_config:
        # environment.extend(map(lambda conf, value: f'TF_VAR_{conf}={value}', extra_config))
        for config, value in extra_config.items():
            environment.append(f'TF_VAR_{config}={value}')

    volumes = {
        expanduser(f'~/.bedrock/{name}/{key}'): {
            'bind': '/work',
            'mode': 'rw'
        }
    }

    if extra_volumes:
        for volume in extra_volumes:
            vargs = volume.split(':')
            volumes[vargs[0]] = {
                'bind': vargs[1],
                'mode': 'ro'
            }

    try:
        container = client.containers.run(f"bedrock/{name}", action, privileged=True, network_mode='host',
                              remove=True, environment=environment, volumes=volumes, tty=True, detach=True)
        logs = container.logs(stream=True)
        for log in logs:
            print(log.decode('utf-8'), end='')
    except KeyboardInterrupt:
        print(f"Aborting {name}..")
        container.stop()


def apply_blueprints(tf_key, blueprints, action, volumes, config):
    for blueprint in blueprints:
        apply_blueprint(blueprint, tf_key, blueprints[blueprint], action, volumes, config)


def main():
    parser = argparse.ArgumentParser(description='Bedrock Manifest Tool.')
    parser.add_argument('-m', '--manifest', metavar='<manifest_path>', default='manifest.yml', type=argparse.FileType('r'),
                        help='location of manifest file (default: %(default)s)')
    parser.add_argument('-v', '--volumes', metavar='<path:volume>', nargs='+',
                        help='additional volumes mounted to support blueprints')
    parser.add_argument('-c', '--config', metavar='<key=value>', nargs='+',
                        help='additional configuration to support blueprints')
    parser.add_argument('action', metavar='<command>', choices=['init', 'apply', 'plan', 'destroy'],
                        help='manifest action (possible values: %(choices)s)', nargs='?', default='init')

    args = parser.parse_args()

    manifest = parse_manifest(args.manifest)

    varmap = merge_config(manifest['vars'], args.config)

    constellations = manifest['constellations']

    if len(constellations) > 1 and args.action == 'destroy':
        # destroy in reverse order..
        constellations = constellations[::-1]

    for constellation in constellations:
        if 'keyvars' in manifest['constellations'][constellation]:
            constellation_key = resolve_key(manifest['constellations'][constellation]['keyvars'],
                                            args.config, constellation)
            # blueprints = {k:v for (k,v) in manifest['constellations'][constellation].items() if k != 'keyvars'}
            blueprints = manifest['constellations'][constellation]['blueprints']
        else:
            constellation_key = constellation
            blueprints = manifest['constellations'][constellation]

        print(f'conskey={constellation_key}')
        if len(blueprints) > 1 and args.action == 'destroy':
            # destroy in reverse order..
            blueprints = blueprints[::-1]

        apply_blueprints(constellation_key, blueprints, args.action, args.volumes, varmap)


if __name__ == "__main__":
    main()
