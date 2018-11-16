output "username" {
  value = "${aws_iam_user.users.*.name}"
}

output "access_key" {
  value = "${aws_iam_access_key.users.*.id}"
}

output "secret_key" {
  value = "${aws_iam_access_key.users.*.secret}"
}

output "path" {
  value = "${aws_iam_user.users.*.path}"
}
