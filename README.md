# bedrock
Infrastructure configuration for micronode applications

## Developer Environment

Use the following tools to provision a pre-configured developer environment.

### Vagrant

    $ vagrant up
    $ ssh -p 2222 -L 8080:localhost:8080 vagrant@localhost  # password: vagrant

### Docker

    $ docker build -t bedrock-env .
    $ ./developer-env.sh
