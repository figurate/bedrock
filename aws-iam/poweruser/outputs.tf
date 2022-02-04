output "poweruser_name" {
  description = "The username of the provisioned power user"
  value       = "${aws_iam_user.poweruser.name}"
}

output "aws_access_key_id" {
  description = "The AWS access key associated with the power user"
  value       = "${aws_iam_access_key.poweruser.id}"
}

output "aws_secret_access_key" {
  description = "The AWS access key secret associated with the power user"
  value       = "${aws_iam_access_key.poweruser.secret}"
}
