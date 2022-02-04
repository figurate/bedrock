resource "aws_resourcegroups_group" "group" {
  name = "${var.environment}-resources"
  resource_query {
    query = <<EOF
{
  "ResourceTypeFilters": [
    "AWS::EC2::Instance"
  ],
  "TagFilters": [
    {
      "Key": "Environment",
      "Values": ["${var.environment}"]
    }
  ]
}
EOF
  }
}
