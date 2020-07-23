[principle of least privilege]: https://en.wikipedia.org/wiki/Principle_of_least_privilege

[Docker]: https://docker.com
[Terraform]: https://terraform.io
[Cloudformation]: https://aws.amazon.com/cloudformation/
[Terragrunt]: https://github.com/gruntwork-io/terragrunt
[Astro]: https://github.com/uber/astro

## Introduction

Bedrock is a tool for provisioning infrastructure and services in a portable and consistent way.
Bedrock provides Terraform-based blueprints and a collection of fine-grained roles to assist with maintaining 
sprawling infrastructure and services across multiple platforms. 

When we design modern computing architectures it is important to consider security, 
reliability and efficiency as equally important concerns. With public Cloud architectures in particular, security must 
be addressed throughout the entire architecture, and not just at the perimiter.

Role-based access control (RBAC) allows us to restrict actors to the minimum required permissions, which is commonly 
referred to as the [principle of least privilege], and is the basis for the architectural blueprints provided by 
Bedrock. 
