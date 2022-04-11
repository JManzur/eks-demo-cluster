#JManzur - 06/2021
#Deploy VPC using AWS VPC Module 
#Registry: https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "eks-vpc"
  cidr = "10.48.0.0/16"

  #AZ's and Subnets Definition
  azs             = ["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c"]
  private_subnets = ["10.48.10.0/24", "10.48.11.0/24", "10.48.12.0/24"]
  public_subnets  = ["10.48.20.0/24", "10.48.21.0/24", "10.48.22.0/24"]

  tags                = merge(var.project-tags, { Name = "${var.resource-name-tag}-vpc" }, )
  private_subnet_tags = merge(var.project-tags, { Name = "${var.resource-name-tag}-private_subnet" }, )
  public_subnet_tags  = merge(var.project-tags, { Name = "${var.resource-name-tag}-public_subnet" }, )

  #Routing tables 
  manage_default_route_table = true

  default_route_table_tags = merge(var.project-tags, { Name = "${var.resource-name-tag}-rt" }, )
  private_route_table_tags = merge(var.project-tags, { Name = "${var.resource-name-tag}-private_rt" }, )
  public_route_table_tags  = merge(var.project-tags, { Name = "${var.resource-name-tag}-public_rt" }, )

  #Nat Gateway
  enable_nat_gateway = true
  single_nat_gateway = true

  nat_gateway_tags = merge(var.project-tags, { Name = "${var.resource-name-tag}-ng" }, )

  #Deny all SG:
  manage_default_security_group  = true
  default_security_group_ingress = []
  default_security_group_egress  = []

  default_security_group_tags = merge(var.project-tags, { Name = "${var.resource-name-tag}-sg" }, )

  #VPC Flow Logs 
  enable_flow_log                      = true
  create_flow_log_cloudwatch_log_group = true
  create_flow_log_cloudwatch_iam_role  = true
  flow_log_max_aggregation_interval    = 60

  vpc_flow_log_tags = merge(var.project-tags, { Name = "${var.resource-name-tag}-vpc_logs" }, )
}