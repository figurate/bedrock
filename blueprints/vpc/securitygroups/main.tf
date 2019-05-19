data "aws_vpc" "tenant" {
  default = "${var.vpc_default}"
  tags = "${var.vpc_tags}"
}

data "aws_subnet_ids" "subnets" {
  vpc_id = "${data.aws_vpc.tenant.id}"
  tags {
    Name = "${var.subnet_filter}"
  }
}

data "aws_subnet" "subnets" {
  count = "${length(data.aws_subnet_ids.subnets.ids)}"
  id = "${data.aws_subnet_ids.subnets.ids[count.index]}"
}
