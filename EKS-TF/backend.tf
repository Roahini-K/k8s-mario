terraform {
  backend "s3" {
    bucket = "roahini-kubemario"
    key    = "EKS/terraform.tfstate"
    region = "us-east-1"
  }
}
