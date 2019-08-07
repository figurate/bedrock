data "aws_vpc" "tenant" {
  default = "${var.vpc_default}"
  tags    = "${var.vpc_tags}"
}

data "aws_subnet_ids" "public" {
  vpc_id = "${data.aws_vpc.tenant.id}"
}

data "aws_subnet_ids" "private" {
  vpc_id = "${data.aws_vpc.tenant.id}"
}

resource "aws_eip" "natgw" {}

resource "aws_nat_gateway" "natgw" {
  allocation_id = "${aws_eip.natgw.id}"
  subnet_id     = "${data.aws_subnet_ids.public.ids[0]}"
}

resource "aws_route_table" "private" {
  vpc_id = "${data.aws_vpc.tenant.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.natgw.id}"
  }
  tags {
    Name = "private_routes"
  }
}

resource "aws_route_table_association" "private" {
  count          = "${length(data.aws_subnet_ids.private.ids)}"
  route_table_id = "${aws_route_table.private.id}"
  subnet_id      = "${data.aws_subnet_ids.private.ids[count.index]}"
}
