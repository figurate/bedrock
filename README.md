# Bedrock - Building blocks for composable Cloud architectures 

[Docker]: https://docker.com
[Terraform]: https://terraform.io
[Cloudformation]: https://aws.amazon.com/cloudformation/

[Introduction]: #introduction

[Features]: #features

[Getting started]: #getting-started
[Requirements]: #requirements
[Configuring]: #configuring


[Examples]: #examples

[Development]: #development

[Contributing]: #contributing

#### Table of Contents

1. [Introduction - What is Bedrock?][Introduction]
2. [Features][Features]
3. [Getting started - How to use Bedrock][Getting started]
	- [Requirements]
	- [Configuring]
    - [Examples - common usage scenarios][Examples]
4. [Development - Guide for contributing to the Bedrock project][Development]
    - [Contributing to Bedrock][Contributing]

## Introduction

Bedrock is a collection of blueprints for building public Cloud infrastructure
using best-practice architectures and techniques. These blueprints are
based on popular tools such as [Terraform] and [Cloudformation], and provide
both an informative and practical approach to infrastructure provisioning.

## Features

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

## Development

### Contributing

Open source software is made stronger by the community that supports it. Through participation you not only contribute to the quality of the software, but also gain a deeper insight into the inner workings.

Contributions may be in the form of feature enhancements, bug fixes, test cases, documentation and forum participation. If you have a question, just ask. If you have an answer, write it down.

And if you are somehow constrained from participation, through corporate policy or otherwise, consider financial support. After all, if you are profiting from open source it's only fair to give something back to the community that make it all possible.

## Developer Environment

Use the following tools to provision a pre-configured developer environment.

### Vagrant

    $ vagrant up
    $ ssh -p 2222 -L 8080:localhost:8080 vagrant@localhost  # password: vagrant

### Docker

    $ docker build -t bedrock-env .
    $ ./developer-env.sh
