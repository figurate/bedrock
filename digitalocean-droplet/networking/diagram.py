from diagrams import Diagram
from diagrams.onprem.iac import Terraform
from diagrams.aws.storage import S3

with Diagram("Digital Ocean Networking", show=False, direction="TB"):
    Terraform("organization")
    S3("terraform_state")
