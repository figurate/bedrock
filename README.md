# Bedrock - infrastructure blueprints

[Docker]: https://docker.com
[Terraform]: https://terraform.io
[Cloudformation]: https://aws.amazon.com/cloudformation/

[Introduction]: #introduction

[Getting started]: #getting-started
[Requirements]: #requirements
[Configuring]: #configuring


#### Table of Contents

1. [Introduction - What is Bedrock?][Introduction]
2. [Getting started - How to use Bedrock][Getting started]
	- [Requirements]
	- [Configuring]

## Introduction

Bedrock is a collection of blueprints for building public Cloud infrastructure
using best-practice architectures and techniques. These blueprints are
based on popular tools such as [Terraform] and [Cloudformation], and provide
both an informative and practical approach to infrastructure provisioning.

## Getting started

### Requirements

To make use of Bedrock you must have access to a public Cloud and a local
environment with [Docker] installed.

If you intend to build the Docker images from source you will also require
make to be installed.

### Configuring

Configuration will depend on the Cloud environment(s) available, but typically
will involve setting an API key in your environment that allows [Terraform]
access to resources in your account.

When using API keys we want to restrict access to the bare minimum required
to perform the required tasks (Principle of least privilege). As such you
should ensure the associated user has just the permissions outlined in the
table below:

| Cloud Provider | Service | Permission |
|----------------|:-------:|:----------:|
|AWS|Codebuild|Execute|
|Digital Ocean|API|Full access|

### Terraform

You can manage your Terraform state using either local storage or with an AWS S3 bucket.
It is advisable to use S3 to protect your state, in which case you will require a user with
the following IAM permissions:

| IAM Permission | Description | ARN |
|----------------|-------------|-----|
|S3 Bucket create|Creates an S3 bucket containing Terraform state|arn:aws:iam::&lt;AWS account ID&gt;:policy/bedrock-terraform-state|
|IAM Policy create|Creates an IAM policy to allow access to read/write to the S3 Bucket|arn:aws:iam::&lt;AWS account ID&gt;:policy/bedrock-terraform-state|


### AWS

For provisioning blueprints in AWS you will require a user with the following IAM permissions:

| IAM Permission | Description | ARN |
|----------------|-------------|-----|
|Terraform state (*)|Read/write permissions to S3 bucket containing Terraform state|arn:aws:iam::&lt;AWS account ID&gt;:policy/bedrock-terraform-state|
|Assume role|Can assume role required for blueprint provisioning|arn:aws:iam::&lt;AWS account ID&gt;:role/*-bedrock-*|

* Note that the `Terraform state` permission is only required when state is stored in AWS.

## Developer Environment

Use the following tools to provision a pre-configured developer environment.

### Vagrant

    $ vagrant up
    $ ssh -p 2222 -L 8080:localhost:8080 vagrant@localhost  # password: vagrant

### Docker

    $ docker build -t bedrock-env .
    $ ./developer-env.sh

## Accelerators

### Bastion

    $ TF_BACKEND=bastion accelerator/bastion/scripts/do.sh