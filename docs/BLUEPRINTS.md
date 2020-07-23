# Table of Blueprints

[compute]: https://placehold.it/15/f03c15/000000?text=+ "red"
[persistence]: https://placehold.it/15/c5f015/000000?text=+ "green"
[network]: https://placehold.it/15/1589f0/000000?text=+ "blue"
[security]: https://placehold.it/15/3cf0f0/000000?text=+ "aqua"
[monitoring]: https://placehold.it/15/f0f03c/000000?text=+ "yellow"
[orchestration]: https://placehold.it/15/f03cf0/000000?text=+ "purple"
[application]: https://placehold.it/15/a52a2a/000000?text=+ "brown"

[apachesling-server]: ../blueprints/apachesling/server "Apache Sling VM"

| Blueprint | Description | Category |
|-----------|-------------|----------|
| [apachesling-server] | Apache Sling VM | ![compute] Compute |
| apachesolr-server | Apache Solr VM | ![compute] Compute |
| aws-backup | AWS Backup Plan | ![persistence] Persistence |
| aws-batch | AWS Batch Job | ![compute] Compute |
| aws-budgets | AWS Budgets | ![monitoring] Monitoring |
| aws-cdk | AWS CDK | ![orchestration] Orchestration |
| aws-chime | AWS Chime Notifications | ![network] Network |
| aws-cloudfront | AWS CloudFront | ![network] Network |
| aws-cloudwatch | AWS CloudWatch | ![monitoring] Monitoring |
| aws-codebuild | AWS CodeBuild | ![orchestration] Orchestration |
| aws-cognito | AWS Cognito | ![security] Security |
| aws-config | AWS Config Rules | ![security] Security |
| aws-dynamodb | AWS DynamoDB Tables | ![persistence] Persistence |
| aws-ec2 | AWS EC2 AutoScaling | ![compute] Compute |
| aws-ecr | AWS ECR Repositories | ![persistence] Persistence |
| aws-ecs | AWS ECS Clusters | ![compute] Compute |
| aws-iam | AWS IAM Users | ![security] Security |
| aws-lambda | AWS Lambda | ![compute] Compute |
| aws-rds | AWS RDS Databases | ![persistence] Persistence |
| aws-route53 | AWS Route53 Zones | ![network] Network |
| aws-s3 | AWS S3 Buckets | ![persistence] Persistence |
| aws-ses | AWS SES | ![network] Network |
| aws-sns | AWS SNS Topics | ![network] Network |
| aws-spotfleet | AWS SpotFleet Clusters | ![compute] Compute |
| aws-ssm | AWS SSM Resource Groups | ![orchestration] Orchestration |
| aws-vpc | AWS VPC Subnets | ![network] Network |
| awstats-server | AWStats VM | ![monitoring] Monitoring |
| azure-container | Azure Containerisation | ![compute] Compute |
| bastion-aws | Bastion Host for AWS | ![network] Network |
| bastion-do | Bastion Host for Digital Ocean | ![network] Network |
| bastion-openstack | Bastion Host for OpenStack | ![network] Network |
| cdn-endpoint | CDN Endpoint Configuration | ![network] Network |
| dns-alias | DNS ALIAS Record | ![network] Network |
| dns-domain | DNS Domain Configuration | ![network] Network |
| dns-record | DNS Record Configuration | ![network] Network |
| dns-redirect | DNS Redirect Configuration | ![network] Network |
| docker-engine | Docker VM | ![compute] Compute |
| elasticsearch-cluster | ElasticSearch Cluster | ![compute] Compute |
| encryption-key | PKI Encryption Key | ![security] Security |
| encryption-tls | PKI TLS Certificate | ![security] Security |
| feed-subscription | Manage Feed Subscriptions | ![application] Application |
| firewall-egress | Firewall Egress Rules | ![network] Network |
| firewall-ingress | Firewall Ingress Rules | ![network] Network |
| grafana-cloudwatch | Grafana CloudWatch Integration | ![monitoring] Monitoring |
| hashicorp-vault | Hashicorp Vault VM | ![security] Security |
| kubenetes-cluster | Kuberbetes Cluster | ![compute] Compute |
| kubenetes-service | Kuberbetes Service | ![compute] Compute |
| netdata-ecs | Netdata ECS Daemon Service | ![monitoring] Monitoring |
| network-private | Private Networking | ![network] Network |
| nginx-reverseproxy | NGINX Reverse Proxy VM | ![network] Network |
| nginx-vhost | NGINX Virtual Host Configuration | ![network] Network |
| orientdb-graph | OrientDB Graph DB VM | ![persistence] Persistence |
| rancher-env | Rancher Environment Configuration | ![orchestration] Orchestration |
| rancher-server | Rancher Server VM | ![compute] Compute |
| rancher-stack | Rancher Stack Configuration | ![orchestration] Orchestration |
| squidproxy-aws | Squid Proxy VM | ![network] Network |
| storage-block | Block Storage (Volume) Configuration | ![persistence] Persistence |
| storage-bucket | Bucket Storage (Object) Configuration | ![persistence] Persistence |
| storage-file | File Storage Tools | ![persistence] Persistence |
| swapfile-linux | Swapfile Configuration | ![compute] Compute |
 |