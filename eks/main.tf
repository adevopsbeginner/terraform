locals {
  tags = {
    Name        = var.this_name
    deployment  = var.deployment
    created_by  = var.created_by
    link        = var.link
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~>5.0"

  name             = "${var.this_name}"
  cidr             = var.vpc_cidr
  azs              = ["${var.aws_region}a", "${var.aws_region}b"]
  public_subnets   = var.public_subnet_cidrs
  private_subnets  = var.private_subnet_cidrs
  database_subnets = var.database_subnet_cidrs
  
  enable_dns_support   = true
  enable_dns_hostnames = true

  map_public_ip_on_launch = true

  tags = {
    deployment  = var.deployment
    created_by  = var.created_by
    link        = var.link
  }
}

resource "aws_security_group" "this" {
  name        = "${var.this_name}-eks-sg"
  description = "${var.this_name}-eks-sg"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description      = "ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = var.whitelist
  }

  ingress {
    description      = "https"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.this_name}-eks-sg"
    deployment  = var.deployment
    created_by  = var.created_by
    link        = var.link
  }

  lifecycle {
    create_before_destroy = true
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "${var.this_name}-cluster"
  cluster_version = var.cluster_version

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  #enable_cluster_creator_admin_permissions = true

  cluster_addons = {
    coredns = {
      resolve_conflicts = "OVERWRITE"
    }
    kube-proxy = {}
    vpc-cni = {
      resolve_conflicts = "OVERWRITE"
    }
  }

  cluster_encryption_config = [/*{
    provider_key_arn = "ac01234b-00d9-40f6-ac95-e42345f78b00"
    resources        = ["secrets"]
  }*/]

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnets

  eks_managed_node_group_defaults = {
    disk_size      = 16
    instance_types = [var.instance_type]

    min_size     = 1
    max_size     = 3
    desired_size = 1

    capacity_type  = "SPOT" ## "ON_DEMAND | SPOT"

    tags = local.tags
  }

  eks_managed_node_groups = {
    "${var.this_name}-uno" = {
      tags     = local.tags
    }
  }

  access_entries = {
    "abeginner" = {
      principal_arn = "arn:aws:iam::471112672291:user/abeginner"
      policy_associations = {
        admin = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type       = "cluster"
          }
        }
      }
    }
    "eks-access-role" = {
      principal_arn = "arn:aws:iam::471112672291:role/eks-access-role"
      policy_associations = {
        view = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSViewPolicy"
          access_scope = {
            type       = "cluster"
          }
        }
      }
    }
  }

  tags = local.tags
}
