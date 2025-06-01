resource "aws_s3_bucket" "my_bucket" {
    bucket = "anki-bucket-s3"
    lifecycle {
      prevent_destroy = true
    }
  
  tags = {
    Name = "anki-bucket-s3"
    Environment =  "Dev"
  }
}

resource "aws_s3_bucket_versioning" "v1" {
  bucket = aws_s3_bucket.my_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}