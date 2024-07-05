resource "aws_s3_bucket" "cielum_bucket" {
  bucket = "cielum-static-site"

  tags = merge({
    Name = "cielum-static-site"
  }, local.tags)
}

resource "aws_s3_bucket_ownership_controls" "cielum_bucket_owner" {
  bucket = aws_s3_bucket.cielum_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "cielum_public_access_block" {
  bucket = aws_s3_bucket.cielum_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "cielum_cf_access" {
  bucket = aws_s3_bucket.cielum_bucket.id
  policy = data.aws_iam_policy_document.cielum_bucket_policy.json
}
