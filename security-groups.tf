
resource "aws_security_group" "worker_group_mgmt_one" {
  name_prefix = "worker_group_mgmt_one"
  vpc_id      = module.vpc.vpc_id
  tags        = merge(var.project-tags, { Name = "${var.resource-name-tag}-mgmt-one-sg" }, )

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/8",
    ]
  }
}

# resource "aws_security_group" "worker_group_mgmt_two" {
#   name_prefix = "worker_group_mgmt_two"
#   vpc_id      = module.vpc.vpc_id
#   tags        = merge(var.project_tags, { Name = "${var.resource-name-tag}-mgmt-two-sg" }, )

#   ingress {
#     from_port = 22
#     to_port   = 22
#     protocol  = "tcp"

#     cidr_blocks = [
#       "192.168.0.0/16",
#     ]
#   }
# }

# resource "aws_security_group" "all_worker_mgmt" {
#   name_prefix = "all_worker_management"
#   vpc_id      = module.vpc.vpc_id
#   tags        = merge(var.project_tags, { Name = "${var.resource-name-tag}-all-worker-sg" }, )

#   ingress {
#     from_port = 22
#     to_port   = 22
#     protocol  = "tcp"

#     cidr_blocks = [
#       "10.0.0.0/8",
#       "172.16.0.0/12",
#       "192.168.0.0/16",
#     ]
#   }
# }

/* Bastion host - Security Group */

# Capture Username and User Public IP.
data "external" "my_public_ip" {
  program = [coalesce("scripts/my_public_ip.sh")]
}

resource "aws_security_group" "bastion_host" {
  name        = "bastion_host"
  description = "SSH and Jenkins Ports"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "SSH from ${data.external.my_public_ip.result["username"]} Public IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [data.external.my_public_ip.result["my_public_ip"]]
  }

  egress {
    description      = "Allow Internet Out"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(var.project-tags, { Name = "${var.resource-name-tag}-bastion-sg" }, )
}