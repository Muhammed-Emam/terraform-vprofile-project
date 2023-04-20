resource "aws_db_subnet_group" "rds-subgrp" {
  name       = "rds-gp"
  subnet_ids = [module.vpc.private_subnets[0].id, module.vpc.private_subnets[1].id, module.vpc.private_subnets[2].id]

  tags = {
    name = "subnet group for RDS"
  }
}

resource "aws_elsticache_subnet_group" "ecache-subgrp" {
  name       = "ecache-subgrp"
  subnet_ids = [module.vpc.private_subnets[0].id, module.vpc.private_subnets[1].id, module.vpc.private_subnets[2].id]

  tags = {
    name = "subnet group for RDS"
  }
}


resource "aws_db_instance" "rds" {
  allocated_storage      = 10
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.6.34"
  instance_class         = "db.t2.micro"
  name                   = var.DB_NAME
  username               = var.DB_USER
  password               = var.DB_PASS
  parameter_group_name   = "default.mysql5.6"
  multi_az               = "false"
  publicly_accessible    = "false"
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.rds-subgrp.name
  vpc_security_group_ids = [aws_security_group.backend-sg.id]
}


esource "aws_elasticache_cluster" "ecache" {
  cluster_id           = "vprofile-ecache"
  engine               = "memcached"
  node_type            = "cache.m4.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.memcached1.5"
  port                 = 11211
  subnet_group_name    = aws_elsticache_subnet_group.ache-subgrp.name
  security_group_ids   = [aws_security_group.backend-sg.id]
}

resource "aws_mq_broker" "example" {
  broker_name        = "vprofile-rmq"
  engine_type        = "ActiveMQ"
  engine_version     = "5.15.0"
  host_instance_type = "mq.t2.micro"
  security_groups    = [aws_security_group.backend-sg.id]
  subnet_ids         = [module.vpc.private_subnets[0]]

  user {
    username = var.RMQ_USER
    password = var.RMQ_PASS
  }
}
