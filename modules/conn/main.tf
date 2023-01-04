
resource "oci_database_tools_database_tools_connection" "mysql_connection" {
    compartment_id  = var.compartment_ocid
    display_name    = var.connection_name
    type = "MYSQL"

    connection_string = "mysql://${local.mysql_hostname}:${local.mysql_port}"

    related_resource {
        #Required
        entity_type = "MYSQLDBSYSTEM"
        identifier  = var.mysql_db_ocid
    }

    user_name = "admin"
    user_password {
        secret_id   = var.db_password_ocid
        value_type  = "SECRETID"
    }
}
