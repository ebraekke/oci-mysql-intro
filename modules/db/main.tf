

resource "oci_mysql_mysql_db_system" "innodb_cluster" {
    # Required
    admin_password      = base64decode(var.db_password_base64) 
    admin_username      = var.db_user_name
    availability_domain = var.avadom_name
    compartment_id      = var.compartment_ocid

    shape_name          = var.shape_name
    subnet_id           = var.subnet_ocid

    backup_policy {
        is_enabled        = true
        retention_in_days = 10
        window_start_time = "00:00:00.00Z"   # midnight UTC
    }

    data_storage_size_in_gb = var.db_gb_storage
    description             = var.db_name
    display_name            = var.db_name
    hostname_label          = var.db_name
    is_highly_available     = true

    maintenance {
        window_start_time   = "sun 21:00:00.00Z"
    }
}
