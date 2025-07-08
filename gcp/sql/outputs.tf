output "postgres_instance_info" {
  sensitive = true
  value = {
    instance_name            = module.postgresql_db.instance_name
    dns_name = module.postgresql_db.dns_name
    env_vars = module.postgresql_db.env_vars
    iam_users = module.postgresql_db.iam_users
    instance_connection_name = module.postgresql_db.instance_connection_name
    instance_first_ip_address = module.postgresql_db.instance_first_ip_address
    instance_ip_address = module.postgresql_db.instance_ip_address
    instances = module.postgresql_db.instances
    private_ip_address = module.postgresql_db.private_ip_address
    public_ip_address = module.postgresql_db.public_ip_address
    # region          = module.postgresql_db.region
    # connection_name = module.postgresql_db.connection_name
    # public_ip       = module.postgresql_db.public_ip_address
    # private_ip      = module.postgresql_db.private_ip_address
    # database_name   = module.postgresql_db.database_name
    # user_name       = module.postgresql_db.user_name
    instance_self_link = module.postgresql_db.instance_self_link
  }
}
