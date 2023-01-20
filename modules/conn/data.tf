
data "oci_mysql_mysql_db_system" "mysql_db_system" {
    db_system_id = var.mysql_db_ocid
}
