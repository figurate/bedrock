data "archive_file" "layer" {
  output_path = "${var.layer_name}.zip"
  type = "zip"
  source_dir = "${var.content_path}"
}

resource "aws_lambda_layer_version" "layer" {
  filename = "${data.archive_file.layer.output_path}"
  layer_name = "${var.layer_name}"
  description = "${var.description}"
  compatible_runtimes = "${var.runtimes}"
  source_code_hash = "${base64sha256(file(data.archive_file.layer.output_path))}"
}
