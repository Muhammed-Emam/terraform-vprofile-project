variable "AWS_REGION" {
  default = "us-east-2"
}

variable "AMIS" {
  type = map(any)
  default = {
    us-east-1  = "ami-0b0f111b5dcb1500f"
    us-east-2  = "ami-0b0f111b5dcb2800f"
    ap-south-1 = "ami-0b0f111b5dcb1400f"
  }
}

variable "map_public_ip_on_launch" {
  type    = bool
  default = true
}

variable "PRIV_KEY_PATH" {
  default   = "vprofilekey.pem"
  sensitive = true
}

variable "PUB_KEY_PATH" {
  default   = "vprofile.pub"
  sensitive = true
}

variable "MYIP" {
  default = "156.195.252.54/32"
}

variable "RMQ_USER" {
  default = "rabbit"
}

variable "RMQ_PASS" {
  default = "emam1234"
}

variable "DB_USER" {
  default = "admin"
}

variable "DB_PASS" {
  default = "admin123"
}

variable "DB_NAME" {
  default = "account"
}

variable "INSTANCE_COUNT" {
  default = "1"
}

variable "VPC_NAME" {
  default = "vprofile-VPC"
}

variable "AZ1" {
  default = "us-east-2a"
}

variable "AZ2" {
  default = "us-east-2b"
}

variable "AZ3" {
  default = "us-east-2c"
}

variable "VPC_CIDR" {
  default = "10.0.0.0/16"
}

variable "PUB_SUB1_CIDR" {
  default = "10.0.1.0/24"
}

variable "PUB_SUB2_CIDR" {
  default = "10.0.2.0/24"
}

variable "PUB_SUB3_CIDR" {
  default = "10.0.3.0/24"
}

variable "PRI_SUB1_CIDR" {
  default = "10.0.4.0/24"
}

variable "PRI_SUB2_CIDR" {
  default = "10.0.5.0/24"
}

variable "PRI_SUB3_CIDR" {
  default = "10.0.6.0/24"
}

variable "USERNAME" {
  default = "ubuntu"
}



/* variable "SUBNETS_CIDR" {
    type = list(string)
    default = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24","10.0.4.0/24","10.0.5.0/24","10.0.6.0/24"]
} */























