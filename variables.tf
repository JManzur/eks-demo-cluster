#Region
variable "aws_region" {
  type    = string
  default = "us-east-1"
}

/* Tags Variables */
#Use: tags = merge(var.project-tags, { Name = "${var.resource-name-tag}-place-holder" }, )
variable "project-tags" {
  type = map(string)
  default = {
    service     = "AWS EKS Demo",
    environment = "demo"
    owner       = "example@mail.com"
  }
}

variable "resource-name-tag" {
  type    = string
  default = "eks-demo"
}

/* EKS Cluster Node EC2 Instance type */
#instance_types  = element([var.instance_type], 0)
variable "instance_type" {
  type = list(string)
  default = [
    "t2.small",
    "t2.medium",
    "t2.large",
    "t2.xlarge",
    "t2.2xlarge"
  ]
}

/* EC2 Instance type */
#Use: instance_type = var.ec2_instance_type["type1"]
variable "ec2_instance_type" {
  type = map(string)
  default = {
    "type1" = "t2.micro"
    "type2" = "t2.small"
    "type3" = "t2.medium"
  }
}

/* SSH Key-Pair */ 

#Bastion Key
variable "bastion_key" {
  type    = string
  default = "Bastion-Key"
}

#EKS Nodes Key
variable "eks_nodes_key" {
  type    = string
  default = "EKS-Nodes-Key"
}

/* EKS Variable */

variable "cluster_name" {
  default = "demo-eks-cluster"
}

variable "cluster_version" {
  description = "Kubernetes version supported by EKS. Ref: https://docs.aws.amazon.com/eks/latest/userguide/kubernetes-versions.html"
  type        = list(string)
  default = [
    "1.21.2",
    "1.20.7",
    "1.19.8",
    "1.18.16",
    "1.17.17"
  ]
}

variable "cluster_log_type" {
  description = "Amazon EKS control plane logging Ref: https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html"
  type        = list(string)
  default = [
    "api",
    "audit",
    "authenticator"
  ]
}

variable "cluster_log_retention_days" {
  default = "90"
}