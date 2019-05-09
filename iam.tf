#This role is used to connect Nextcloud to S3 bucket.
resource "aws_iam_user" "nextclouduser" {
  name = "nextcloud-user"
}
resource "aws_iam_role" "nextcloud-role" {
  name = "nextcloud-role"
  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "ec2.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}


resource "aws_iam_group" "nextcloudgroup" {
  name = "nextcloud-group"
}
 resource "aws_iam_policy" "nextcloud-policy" {
   name = "nextcloud-policy"
   description = "nexcloud policy"
   policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
# Attaching the various groups and roles to one name
 resource "aws_iam_policy_attachment" "nextcloud-attachment" {
   name       = "nextcloud-attachment"
   users      = ["${aws_iam_user.nextclouduser.name}"]
   roles      = ["${aws_iam_role.nextcloud-role.name}"]
   groups     = ["${aws_iam_group.nextcloudgroup.name}"]
   policy_arn = "${aws_iam_policy.nextcloud-policy.arn}"
 }
