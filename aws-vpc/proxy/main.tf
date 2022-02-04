data "aws_vpc" "tenant" {
  default = "${var.vpc_default}"
  tags = "${var.vpc_tags}"
}

data "aws_subnet_ids" "private" {
  vpc_id = "${data.aws_vpc.tenant.id}"
}

resource "aws_eip" "natgw" {}

resource "aws_route_table" "private" {
  vpc_id = "${data.aws_vpc.tenant.id}"
  route {
    cidr_block = "0.0.0.0/0"
    network_interface_id = "${var.proxy_id}"
  }
  tags {
    Name = "private_routes"
  }
}

resource "aws_route_table_association" "private" {
  count = "${length(data.aws_subnet_ids.private.ids)}"
  route_table_id = "${aws_route_table.private.id}"
  subnet_id = "${data.aws_subnet_ids.private.ids[count.index]}"
}
