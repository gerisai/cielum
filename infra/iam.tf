data "aws_iam_policy_document" "cielum_bucket_policy" {
  statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = [
      "${aws_s3_bucket.cielum_bucket.arn}/*",
    ]
  }
}