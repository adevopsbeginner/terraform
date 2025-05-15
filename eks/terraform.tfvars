aws_profile    = "default"
aws_account_no = "471112672291"
aws_region     = "ap-southeast-2"
#this_name      = "t-kbeginner"
created_by     = "adevopsbeginner"
link           = "https://www.youtube.com/@adevopsbeginner"

## instance
instance_type = "t3a.micro"
whitelist     = [
    "203.123.0.0/16",      ### home ip
    ]

iam_instance_profile_arn = "arn:aws:iam::471112672291:instance-profile/eks-node-instance-profile"

## vpc
vpc_cidr              = "10.195.0.0/16"
public_subnet_cidrs   = ["10.195.10.0/24", "10.195.11.0/24"]
private_subnet_cidrs  = ["10.195.20.0/24", "10.195.21.0/24"]
database_subnet_cidrs = ["10.195.30.0/24", "10.195.31.0/24"]

## eks
cluster_version = "1.32"
