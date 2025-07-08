output "vpc_name" {
  value = module.vpc.network_name
}

output "vpc_self_link" {
  value = module.vpc.network_self_link
}

output "vpc_project_id" {
  value = module.vpc.project_id
}

output "route_names" {
  value = module.vpc.route_names
}

output "subnet_names" {
  value = module.vpc.subnets
}

output "subnets_self_links" {
  value = module.vpc.subnets_self_links
}

output "subnets_regions" {
  value = module.vpc.subnets_regions
}

output "subnets_ips" {
  value = module.vpc.subnets_ips
}

output "subnets_flow_logs" {
  value = module.vpc.subnets_flow_logs
}
