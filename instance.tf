resource "aws_instance" "nextcloud" {
  ami          = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  # Giving ec2 role to read and write on s3 bucket
  iam_instance_profile = "${aws_iam_instance_profile.nexcloud-ec2-profile.name}"
  subnet_id = "${aws_subnet.nextcloud-public-1.id}"

  vpc_security_group_ids = ["${aws_security_group.nextcloud-security.id}"]

  key_name = "${aws_key_pair.nextkey.id}"
  instance_initiated_shutdown_behavior = "stop"
  root_block_device ={
    volume_type = "gp2"
    volume_size = 20
    delete_on_termination = "false"
    }

  tags {
    Name = "nextcloud-instance"
  }
}
#ataching ebs volume to isntance
#resource "aws_ebs_volume" "ebs-attach" {
#  availability_zone = "us-east-2a"
#  size = 30
#  type = "gp2"
#  tags {
#    Name = "Nextcloud extra volume"
#  }
#}
#resource "aws_volume_attachment" "ebs-attach" {
#  device_name = "/dev/xvde"
#  volume_id = "${aws_ebs_volume.ebs-attach.id}"
#  instance_id = "${aws_instance.nextcloud.id}"
#}
