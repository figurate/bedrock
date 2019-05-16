data "aws_vpc" "current" {
  filter {
    name = "tag:Name"
    values = ["${var.vpc_name}"]
  }
}

data "aws_subnet_ids" "subnets" {
  vpc_id = "${data.aws_vpc.current.id}"
  tags {
    Name = "${var.subnet_filter}"
  }
}

data "aws_subnet" "subnets" {
  count = "${length(data.aws_subnet_ids.subnets.ids)}"
  id = "${data.aws_subnet_ids.subnets.ids[count.index]}"
}
