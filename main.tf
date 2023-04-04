
module "db" {
    source              = "./modules/db"

    db_name             = "${var.set_name}mysql"
    db_user_name        = var.db_user_name
    db_password_base64  = data.oci_secrets_secretbundle.db_password.secret_bundle_content[0]["content"]
    avadom_name         = local.avadom_name
    compartment_ocid    = var.compartment_ocid
    subnet_ocid         = var.subnet_ocid
    shape_name          = var.db_shapes_map[var.db_cores]
    db_gb_storage       = var.db_gb_storage
}

module "conn" {
    source              = "./modules/conn"

    compartment_ocid    = var.compartment_ocid
    connection_name     = "${var.set_name}mysqlconn"
    mysql_db_ocid       = module.db.db_ocid
    db_user_name        = var.db_user_name
    db_password_ocid    = var.password_ocid
    priv_endpoint_ocid  = var.priv_endpoint_ocid
}
