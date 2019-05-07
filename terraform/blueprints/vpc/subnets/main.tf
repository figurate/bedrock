data "aws_availability_zones" "available" {}

data "aws_vpc" "tenant" {
  id = "${var.vpc}"
}

data "aws_route_table" "subnet_routes" {
  filter {
    name = "tag:Name"
    values = ["${var.route_table}"]
  }
}

resource "aws_subnet" "subnets" {
  count = "${length(data.aws_availability_zones.available.zone_ids)}"
  availability_zone_id = "${element(data.aws_availability_zones.available.zone_ids, count.index)}"
  map_public_ip_on_launch = "${var.is_public}"
  vpc_id = "${data.aws_vpc.tenant.id}"
  cidr_block = "${cidrsubnet(data.aws_vpc.tenant.cidr_block, var.newbits, count.index)}"
  tags {
    Name = "${format("private_subnet_%s", substr(element(data.aws_availability_zones.available.names, count.index), -2, -1))}"
  }
}

resource "aws_route_table_association" "subnet_routes_association" {
  count = "${length(data.aws_availability_zones.available.zone_ids)}"
  subnet_id = "${element(aws_subnet.subnets.*.id, count.index)}"
  route_table_id = "${data.aws_route_table.subnet_routes.id}"
}
