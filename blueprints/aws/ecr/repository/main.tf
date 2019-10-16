/**
 * # ECR Repository Creation
 *
 * Create an ECR repository with lifecycle rules.
 */
resource "aws_ecr_repository" "repository" {
  name = "${var.repository_name}"
}

resource "aws_ecr_lifecycle_policy" "untagged_images" {
  repository = "${aws_ecr_repository.repository.name}"
  policy     = <<EOF
{
  "rules": [
    {
      "rulePriority": 1,
      "description": "Remove untagged images older than ${var.image_expiry} days",
      "selection": {
        "tagStatus": "untagged",
        "countType": "sinceImagePushed",
        "countUnit": "days",
        "countNumber": ${var.image_expiry}
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
EOF
}