output "ami_id" {
  value = "${data.aws_ami.bastion_image.id}"
}

output "instance_ip" {
  value = "${aws_instance.bastion.*.public_ip}"
}
