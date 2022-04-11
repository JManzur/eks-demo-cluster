#Grabbing latest Linux 2 AMI
data "aws_ami" "linux2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

# EC2 Deploy
resource "aws_instance" "bastion-host" {
  ami                    = data.aws_ami.linux2.id
  instance_type          = var.ec2_instance_type["type1"]
  subnet_id              = module.vpc.public_subnets
  key_name               = var.bastion_key
  vpc_security_group_ids = [aws_security_group.bastion_host.id]
  tags                   = merge(var.project-tags, { Name = "${var.resource-name-tag}-bastion" }, )

  root_block_device {
    volume_size           = 80
    volume_type           = "gp2"
    delete_on_termination = true
    tags                  = merge(var.project-tags, { Name = "${var.resource-name-tag}-bastion-EBS" }, )
  }
}

output "ssh_command" {
  value = "sudo ssh -i ~/.ssh/${var.bastion_key}.pem ec2-user@${aws_instance.bastion-host.public_ip}"
}