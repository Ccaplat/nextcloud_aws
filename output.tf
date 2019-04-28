# output "instance" {
#  value = "${aws_instance.nextcloud.public_ip}"
# In case you are using elastic ip uncomment thois
output "eip" {
  value = "${aws_eip.nextcloud_eip.public_ip}"
}
#}
output "aws_s3_bucket" {
  value = "${aws_s3_bucket.nextcloudbucket.id}"
}
output "iam_user"{
  value = "${aws_iam_user.nextclouduser.name}"
}
