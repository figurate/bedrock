#!/usr/bin/env bash
cd $(dirname $0)
docker run --rm -v "$PWD:/work" tmknom/terraform-docs markdown base/do/ >base/do/README.md
docker run --rm -v "$PWD:/work" tmknom/terraform-docs markdown terraform_state/aws/ >terraform_state/aws/README.md
docker run --rm -v "$PWD:/work" tmknom/terraform-docs markdown terraform_state/local/ >terraform_state/local/README.md
docker run --rm -v "$PWD:/work" tmknom/terraform-docs markdown bastion/do/ >bastion/do/README.md
docker run --rm -v "$PWD:/work" tmknom/terraform-docs markdown bastion/aws/ >bastion/aws/README.md
docker run --rm -v "$PWD:/work" tmknom/terraform-docs markdown user/aws/ >user/aws/README.md
docker run --rm -v "$PWD:/work" tmknom/terraform-docs markdown reverseproxy/do/ >reverseproxy/do/README.md
docker run --rm -v "$PWD:/work" tmknom/terraform-docs markdown rancher/do/ >rancher/do/README.md
docker run --rm -v "$PWD:/work" tmknom/terraform-docs markdown rancherenv/do/ >rancherenv/do/README.md
docker run --rm -v "$PWD:/work" tmknom/terraform-docs markdown rancherstack/do/ >rancherstack/do/README.md
docker run --rm -v "$PWD:/work" tmknom/terraform-docs markdown swap/do/ >swap/do/README.md
docker run --rm -v "$PWD:/work" tmknom/terraform-docs markdown storage/aws/ >storage/aws/README.md
docker run --rm -v "$PWD:/work" tmknom/terraform-docs markdown whistlepost/do/ >whistlepost/do/README.md
