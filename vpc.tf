module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vprofile-vpc"
  cidr = var.VPC_CIDR

  azs             = [var.AZ1, var.AZ2, var.AZ3]
  private_subnets = [var.PRI_SUB1_CIDR, var.PRI_SUB2_CIDR, var.PRI_SUB3_CIDR]
  public_subnets  = [var.PUB_SUB1_CIDR, var.PUB_SUB2_CIDR, var.PUB_SUB3_CIDR]

  enable_nat_gateway   = true
  enable_dns_hostnames = true
  single_nat_gateway   = true
  enable_vpn_gateway   = true

  tags = {
    name = var.VPC_NAME
  }
}