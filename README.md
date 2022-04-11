# eks-demo-cluster
Demo AWS EKS Cluster using Terraform

TO-DO
 - Security Groups
 - Add-Ons https://marcincuber.medium.com/amazon-eks-upgrade-journey-from-1-19-to-1-20-78c9a7edddb5
 - https://docs.aws.amazon.com/eks/latest/userguide/eks-add-ons.html
 - Authenticator
 - FIX Instance Type
 - Configure SSH access to nodes


# Title
<div align="center">
 <img src="https://1.bp.blogspot.com/-b7YyMHGBZ08/YYFHdXDqH_I/AAAAAAAAFuY/TFO2pYNrCeEkfFVtI8WVDl2LHrpxlz-BwCLcBGAsYHQ/s16000/under_const.jpg"</img>
</div>

## Resources deployed by this manifest:

### Deployment diagram:

![App Screenshot](https://1.bp.blogspot.com/-Hi0El0U8hM8/YWr6tDGc2fI/AAAAAAAAFtM/0Pn8o1u5_t0RyX__zznN9EQKQo9eaNrMwCLcBGAsYHQ/s16000/demo-vpc.drawio.png)

## Tested with: 

| Environment | Application | Version  |
| ----------------- |-----------|---------|
| WSL2 Ubuntu 20.04 | Terraform | v1.0.0  |

## Initialization How-To:

Located in the root directory, make an "aws configure" to log into the aws account, and a "terraform init" to download the necessary modules and start the backend.

```bash
aws configure
terraform init
```

## Deployment How-To:

### Generate the Two Key-Pair using AWS-CLI:

```bash
#Bastion Key
aws ec2 create-key-pair --key-name Bastion-Key --query 'KeyMaterial' --output text > Bastion-Key.pem

#EKS Nodes Key
aws ec2 create-key-pair --key-name EKS-Nodes-Key --query 'KeyMaterial' --output text > EKS-Nodes-Key.pem
```

>:warning: If you use a different key name, change the "bastion_key" and "eks_nodes_key" variables in the variables.tf file. :warning:

Change permissions:
```bash
#Bastion Key
chmod 400 Bastion-Key.pem

#EKS Nodes Key
chmod 400 EKS-Nodes-Key.pem
```

Move to home folder:
```bash
#Bastion Key
mv Bastion-Key.pem ~/.ssh/Bastion-Key.pem

#EKS Nodes Key
mv EKS-Nodes-Key.pem ~/.ssh/EKS-Nodes-Key.pem
```

## Debugging / Troubleshooting:

#### **Debugging Tip #1**: 

#### **Known issue #1**: 
 - **Issue**: 
- **Cause**: 
- **Solution**: 

## Author:

- [@JManzur](https://jmanzur.com.ar)

## Documentation:

- [Hashicorp Learn: Provision an EKS Cluster](https://learn.hashicorp.com/tutorials/terraform/eks)