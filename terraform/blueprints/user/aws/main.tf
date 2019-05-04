/**
 * # AWS IAM user configuration
 *
 * Provision an IAM user in AWS.
 */
resource "aws_iam_user" "users" {
  count = "${length(var.users)}"
  name = "${element(var.users, count.index)}"
}

resource "aws_iam_access_key" "users" {
  count = "${length(var.users)}"
  user = "${element(var.users, count.index)}"
}

resource "aws_iam_group" "groups" {
  count = "${length(var.groups)}"
  name = "${element(var.groups, count.index)}"
}

resource "aws_iam_group_membership" "group_membership" {
  count = "${length(var.groups)}"
  group = "${var.groups[count.index]}"
  name = "${var.groups[count.index]}-membership"
  users = ["${var.users}"]
}
