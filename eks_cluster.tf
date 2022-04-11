# EKS Cluster Definition:
resource "aws_eks_cluster" "eks-cluster" {
  name                      = var.cluster_name
  role_arn                  = aws_iam_role.EKSAssumeRole.arn
  enabled_cluster_log_types = var.cluster_log_type
  tags                      = merge(var.project-tags, { Name = "${var.resource-name-tag}-cluster" }, )

  vpc_config {
    endpoint_public_access  = false
    endpoint_private_access = true
    subnet_ids              = module.vpc.private_subnets
  }

  depends_on = [
    aws_iam_role_policy_attachment.EKSAssumeRole-Policy,
    aws_iam_role_policy_attachment.EKSAssumeRole-Pods-Policy,
    aws_cloudwatch_log_group.eks-logs
  ]
}

# EKS Log Group
resource "aws_cloudwatch_log_group" "eks-logs" {
  name              = "/aws/eks/${var.cluster_name}/cluster"
  retention_in_days = var.cluster_log_retention_days
  tags              = merge(var.project-tags, { Name = "${var.resource-name-tag}-logs" }, )
}

/* Node Groups Definition: */

# Node Group 1
resource "aws_eks_node_group" "eks-ng-1" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = "eks-ng-1"
  node_role_arn   = aws_iam_role.EC2AssumeRole.arn
  subnet_ids      = module.vpc.private_subnets
  instance_types  = element([var.instance_type], 0)
  tags            = merge(var.project-tags, { Name = "${var.resource-name-tag}-ng-1" }, )

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  remote_access {
    ec2_ssh_key = var.eks_nodes_key
    source_security_group_ids = []
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNode-Policy,
    aws_iam_role_policy_attachment.AmazonEKSCNI-Policy,
    aws_iam_role_policy_attachment.EC2ContainerRegistryRO-Policy,
  ]
}

# Node Group 2
resource "aws_eks_node_group" "eks-ng-2" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = "eks-ng-2"
  node_role_arn   = aws_iam_role.EC2AssumeRole.arn
  subnet_ids      = module.vpc.private_subnets
  instance_types  = element([var.instance_type], 0)
  tags            = merge(var.project-tags, { Name = "${var.resource-name-tag}-ng-2" }, )

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  remote_access {
    ec2_ssh_key = var.eks_nodes_key
    source_security_group_ids = []
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNode-Policy,
    aws_iam_role_policy_attachment.AmazonEKSCNI-Policy,
    aws_iam_role_policy_attachment.EC2ContainerRegistryRO-Policy,
  ]
}

output "endpoint" {
  value = aws_eks_cluster.eks-cluster.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.eks-cluster.certificate_authority[0].data
}