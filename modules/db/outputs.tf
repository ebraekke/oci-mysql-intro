

###########################################################################
# OUTPUT
###########################################################################

output "db_password" {
  value     = local.password
}

output "db_private_ip" {
  value = oci_mysql_mysql_db_system.innodb_cluster.ip_address  
}
