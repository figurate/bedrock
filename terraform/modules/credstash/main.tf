resource "aws_kms_key" "credstash" {}

resource "aws_kms_alias" "credstash" {
  target_key_id = "${aws_kms_key.credstash.id}"
  name = "alias/credstash"
}
