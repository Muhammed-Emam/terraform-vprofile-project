resource "aws_security_group" "beanstalk-elb-sg" {
  name        = "beanstalk-elb-sg"
  description = "sg for beanstalk load balancer"
  vpc_id      = module.vpc.vpc_id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] //outbound traffic are allowed to go anywhere
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] //inbound traffic are allowed from anywhere

  }
}

resource "aws_security_group" "bastion-sg" {
  name        = "bastion-sg"
  description = "sg for bastion host"
  vpc_id      = module.vpc.vpc_id


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] //outbound traffic are allowed to go anywhere
  }


  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] //inbound traffic are allowed from anywhere // var.MY_IP should by used here

  }
}

resource "aws_security_group" "ec2-sg" {
  name        = "ec2-sg"
  description = "sg for ec2 instances"
  vpc_id      = module.vpc.vpc_id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] //outbound traffic are allowed to go anywhere
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_security_group.bastion-sg.id] //allowes only bastion to access it 
  }
}

resource "aws_security_group" "prod-sg" {
  name        = "prod-sg"
  description = "sg for beanstalk instances"
  vpc_id      = module.vpc.vpc_id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] //outbound traffic are allowed to go anywhere
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_security_group.bastion-sg.id] //allowes only bastion to access it 
  }
}

resource "aws_security_group" "backend-sg" {
  name        = "backend-sg"
  description = "sg backend services [RDS , ACTIVE MQ , ELASTIC CACHE ]instances and will be accesed by the bean stalk instances"
  vpc_id      = module.vpc.vpc_id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] //outbound traffic are allowed to go anywhere
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_security_group.prod-sg.id] 
  }
    ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [aws_security_group.bastion-sg.id] //allowes only bastion to access it 
  }

  
}

resource "aws_security_group_rule" "sec_group_allow_itself" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.backend-sg.id
  source_security_group_id = aws_security_group.backend-sg.id
}