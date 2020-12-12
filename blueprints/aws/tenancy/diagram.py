# diagram.py
from diagrams import Diagram, Cluster
from diagrams.aws.network import CloudMap, VPC

with Diagram("AWS Tenancy", show=False, direction="RL"):

    with Cluster("dns"):
        CloudMap("private dns namespace") << VPC("vpc")
        CloudMap("public dns namespace")
