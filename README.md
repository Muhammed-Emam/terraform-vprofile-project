# terraform-vprofile-project
![Screenshot from 2023-04-20 05-12-24](https://user-images.githubusercontent.com/118661263/233251303-26f7a2df-1dbe-43bc-87f3-868cbd236ac9.png)
![Screenshot from 2023-04-20 05-33-51](https://user-images.githubusercontent.com/118661263/233251723-75057d7e-5a01-4efe-9502-680fac5f41fd.png)


# Terraform Project

This project deploys a VPC with multiple subnets across multiple availability zones, NAT gateways, and an Elastic Beanstalk environment for deploying EC2 instances. Additionally, it includes several backend services including RDS MySQL, an Elasticache cluster, and RabbitMQ. A bastion host is used in the public subnet to set up and integrate these services with the Elastic Beanstalk environment using automated scripts.

## Infrastructure

The following resources are created by the Terraform configuration:

- VPC with 6 subnets across 3 availability zones
- NAT gateways
- Elastic Beanstalk environment for deploying EC2 instances
- RDS MySQL database
- Elasticache cluster
- RabbitMQ

## Usage

1. Clone the repository.
2. Navigate to the project directory.
3. Run `terraform init` to initialize the project.
4. Create a `terraform.tfvars` file and populate it with the required variables.
5. Run `terraform apply` to create the infrastructure.

## Variables

The following variables can be set in the `terraform.tfvars` file:

- `region`: The AWS region to create the infrastructure in.
- `vpc_cidr_block`: The CIDR block for the VPC.
- `public_subnet_cidr_blocks`: The CIDR blocks for the public subnets.
- `private_subnet_cidr_blocks`: The CIDR blocks for the private subnets.
- `db_name`: The name of the RDS MySQL database.
- `db_username`: The username for the RDS MySQL database.
- `db_password`: The password for the RDS MySQL database.
- `cache_node_type`: The Elasticache node type.
- `cache_engine_version`: The Elasticache engine version.
- `rabbitmq_username`: The username for the RabbitMQ server.
- `rabbitmq_password`: The password for the RabbitMQ server.

## Outputs

The following resources are created by the Terraform configuration:

- VPC ID
- Public subnet IDs
- Private subnet IDs
- NAT gateway IDs
- Elastic Beanstalk environment URL
- RDS MySQL endpoint
- Elasticache endpoint
- RabbitMQ endpoint

## Clean up

To delete the infrastructure, run `terraform destroy`.
