resource "aws_s3_bucket" "gut-checker-bucket" {
  bucket = "tf-gut-checker-bucket"
  region = "us-east-1"

  tags = {
    Name        = "Gut Check Assignment Bucket"
    Environment = "Dev"
  }
}
resource "aws_s3_bucket_public_access_block" "gut-checker-bucket_block" {
  bucket = aws_s3_bucket.gut-checker-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.gut-checker-bucket.id

  depends_on = [aws_s3_bucket_public_access_block.gut-checker-bucket_block]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicAccess"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.gut-checker-bucket.arn}/*"
      }
    ]
  })
}

resource "aws_s3_object" "honey_badger" {
  bucket       = aws_s3_bucket.gut-checker-bucket.id
  key          = "honey_badger.jpg"
  source       = "./images/honey_badger.jpg"
  content_type = "image/jpeg"

  etag = filemd5("./images/honey_badger.jpg")
}
resource "aws_s3_object" "webhook_working" {
  bucket       = aws_s3_bucket.gut-checker-bucket.id
  key          = "1-working_webhook.png"
  source       = "./images/1-working_webhook.png"
  content_type = "image/png"

  etag = filemd5("./images/1-working_webhook.png")
}

resource "aws_s3_object" "deploy_success" {
  bucket       = aws_s3_bucket.gut-checker-bucket.id
  key          = "deploy_success.png"
  source       = "./images/deploy_success.png"
  content_type = "image/png"

  etag = filemd5("./images/deploy_success.png")
}

resource "aws_s3_object" "pending_approval" {
  bucket       = aws_s3_bucket.gut-checker-bucket.id
  key          = "pending_approval.jpg"
  source       = "./images/pending_approval.jpg"
  content_type = "image/jpeg"

  etag = filemd5("./images/pending_approval.jpg")
}

resource "aws_s3_object" "bucket_created" {
  bucket       = aws_s3_bucket.gut-checker-bucket.id
  key          = "s3_bucket_created.png"
  source       = "./images/s3_bucket_created.png"
  content_type = "image/png"

  etag = filemd5("./images/s3_bucket_created.png")
}
