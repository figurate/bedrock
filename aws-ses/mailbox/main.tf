data "aws_caller_identity" "current" {}

data "aws_s3_bucket" "mailboxes" {
  bucket = "${data.aws_caller_identity.current.account_id}-${var.mailbox_bucket}"
}

resource "aws_ses_receipt_rule" "mailbox" {
  name = "${var.mailbox_id}"
  rule_set_name = "default-rule-set"
  recipients = ["${var.mailbox_id}"]
  enabled = true
  scan_enabled = true
  s3_action {
    position = 1
    bucket_name = "${data.aws_s3_bucket.mailboxes.bucket}"
    object_key_prefix = "${var.mailbox_id}/inbox"
  }
}
