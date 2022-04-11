### Cluster IAM Role
resource "aws_iam_role" "EKSAssumeRole" {
  name = "EKSAssumeRole"
  tags = merge(var.project-tags, { Name = "${var.resource-name-tag}-eks-role" }, )

  assume_role_policy = file("iam-policy/EKSAssumeRole.json")
}

resource "aws_iam_role_policy_attachment" "EKSAssumeRole-Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.EKSAssumeRole.name
}

resource "aws_iam_role_policy_attachment" "EKSAssumeRole-Pods-Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.EKSAssumeRole.name
}

### Node Group IAM Role
resource "aws_iam_role" "EC2AssumeRole" {
  name = "EC2AssumeRole"
  tags = merge(var.project-tags, { Name = "${var.resource-name-tag}-ec2-role" }, )

  assume_role_policy = file("iam-policy/EC2AssumeRole.json")
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNode-Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.EC2AssumeRole.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKSCNI-Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.EC2AssumeRole.name
}

resource "aws_iam_role_policy_attachment" "EC2ContainerRegistryRO-Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.EC2AssumeRole.name
}
