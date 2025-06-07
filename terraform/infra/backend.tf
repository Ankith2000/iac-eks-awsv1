terraform {
  backend "s3" {
    bucket = "anki-bucket-s3"
    key = "anki-linux.pem"
    region = "ap-south-1"
    use_lockfile = true
  }
}