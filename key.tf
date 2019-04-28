resource "aws_key_pair" "nextkey"{
  key_name = "nextkey"
  public_key = "${file("${var.public_key}")}"
}
