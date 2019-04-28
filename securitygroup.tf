resource "aws_security_group" "nextcloud-security" {
  vpc_id = "${aws_vpc.nextcloud.id}"
  name = "ssh and https open port"
  description = " nextcloud security group ssh and https"

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
 }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

tags{
  Name = "nextcloudvpc-security group"
 }
}
