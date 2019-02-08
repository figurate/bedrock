output "vpc_id" {
  value = "${lookup(aws_cloudformation_stack.vpc.outputs, "VpcId")}"
}
