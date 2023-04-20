terraform {
  backend "s3" {
    bucket = "terraform-emam"
    key    = "terraform.tfstate" //does not have to be like this
    region = var.AWS_REGION
  }
}
