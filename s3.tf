resource "aws_s3_bucket" "nextcloudbucket" {
  bucket = "nextcloudtestbucket1112222"
  acl = "private"


  versioning {
    enabled = true
  }

# rule that allows lifecycle
lifecycle_rule {
  enabled = true
# moving data from s3 to standard IA storage
   transition {
    days = 30 # minimum of 30 days
    storage_class = "STANDARD_IA"

    # moving from standard to glacier after 60 days
  }
  transition {
    days = 60
    storage_class = "GLACIER"
  }
}
}
