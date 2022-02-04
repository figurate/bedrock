output "ami_id" {
  value = "${data.aws_ami.autoscaling_image.id}"
}
