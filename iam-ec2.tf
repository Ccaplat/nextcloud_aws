# creating the ec2 role, this will be used to connect our NExtcloud to S3 bucket
resource "aws_iam_role" "nexcloud_ec2_role" {
  name = "nexcloud-ec2-role"
  assume_role_policy = <<EOF
{
"Version": "2012-10-17",
"Statement": [
{
"Action": "sts:AssumeRole",
"Principal": {
"Service": "ec2.amazonaws.com"
},
"Effect": "Allow"
}
]
}
EOF

 tags = {
   tag-key = "nexcloud-ec2-role"
 }
}


# Creating ec2 iam profile and assigned it to our ec2 role
# we gave this profile
resource "aws_iam_instance_profile" "nexcloud-ec2-profile" {
  name = "nexctloud-ec2-profile"
  role = "${aws_iam_role.nexcloud_ec2_role.name}"

}
# Giving ec2 right to access s3
resource "aws_iam_role_policy" "nexcloud-ec2-policy" {
  name = "nexcloud-ec2-policy"
  role = "${aws_iam_role.nexcloud_ec2_role.name}"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "s3:PutAccountPublicAccessBlock",
                "s3:GetAccountPublicAccessBlock",
                "s3:ListAllMyBuckets",
                "cloudwatch:*",
                "s3:HeadBucket"
            ],
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": "arn:aws:s3:::nextcloudtestbucket1112222"
        }
    ]
}
EOF
}
