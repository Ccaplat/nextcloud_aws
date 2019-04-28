resource "aws_eip" "nextcloud_eip" {
  vpc = true
}


resource "aws_eip_association" "eip_assoc" {
  instance_id = "${aws_instance.nextcloud.id}"
  allocation_id = "${aws_eip.nextcloud_eip.id}"
}
