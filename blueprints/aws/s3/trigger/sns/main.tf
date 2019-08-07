data "aws_caller_identity" "current" {}

data "aws_s3_bucket" "source" {
  bucket = "${data.aws_caller_identity.current.account_id}-${var.bucket_name}"
}

data "aws_sns_topic" "trigger" {
  name = "${var.topic_name}"
}

resource "aws_s3_bucket_notification" "trigger" {
  bucket = "${data.aws_s3_bucket.source.id}"
  topic {
    topic_arn     = "${data.aws_sns_topic.trigger.arn}"
    events        = "${var.trigger_events}"
    filter_suffix = "${var.filter_suffix}"
  }
}
