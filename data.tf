data "aws_ssm_parameter" "AMI" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
  #returens the available ami amazon 2 in whatever region i'm using
  #ami                    = nonsensitive(data.aws_ssm_parameter.ami.value)

}

data "aws_availability_zones" "available" {}
#returens a list of availability zones
#availability_zone       = data.aws_availability_zones.available.names[0]

