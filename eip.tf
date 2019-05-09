# allows AWS to assign a static IP to your instance. 
# THis is optional comment if you do not want to use but make sure you also comment the output.tf file for the EIP section.
resource "aws_eip" "nextcloud_eip" {
  vpc = true
}

# this assiciated the IP created on the top to the EC2 instance
resource "aws_eip_association" "eip_assoc" {
  instance_id = "${aws_instance.nextcloud.id}"
  allocation_id = "${aws_eip.nextcloud_eip.id}"
}
