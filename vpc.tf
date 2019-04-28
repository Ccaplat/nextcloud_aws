resource "aws_vpc" "nextcloud" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  enable_classiclink = "false"
  tags {
    Name = "nextvpc"
  }
}
# subnets
resource "aws_subnet" "nextcloud-public-1" {
  vpc_id = "${aws_vpc.nextcloud.id}"
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-2a"
  tags {
    Name = "next-public1"
  }
}

resource "aws_subnet" "nextcloud-public-2" {
  vpc_id = "${aws_vpc.nextcloud.id}"
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-2b"
  tags {
    Name = "next-public2"
  }
}
  resource "aws_subnet" "nextcloud-private-1" {
    vpc_id = "${aws_vpc.nextcloud.id}"
    cidr_block = "10.0.3.0/24"
    map_public_ip_on_launch  = "false"
    availability_zone = "us-east-2a"
    tags {
      Name = "ha-private-1"
    }
  }
  resource "aws_subnet" "nextcloud-private-2" {
    vpc_id = "${aws_vpc.nextcloud.id}"
    cidr_block = "10.0.4.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-2b"
    tags {
      Name = "next-private2"
    }
  }
## adding our internet gateway
resource "aws_internet_gateway" "nextcloud-gateway" {
  vpc_id = "${aws_vpc.nextcloud.id}"
  tags {
    Name = "nextvpc-gateway"
  }
}

resource "aws_route_table" "nextcloud-rt" {
  vpc_id = "${aws_vpc.nextcloud.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.nextcloud-gateway.id}"

}
}
#route association public
resource "aws_route_table_association" "nextcloud-rt-1" {
  subnet_id = "${aws_subnet.nextcloud-public-1.id}"
  route_table_id = "${aws_route_table.nextcloud-rt.id}"
}
resource "aws_route_table_association" "ha-rt-2" {
  subnet_id = "${aws_subnet.nextcloud-public-2.id}"
  route_table_id = "${aws_route_table.nextcloud-rt.id}"
}
