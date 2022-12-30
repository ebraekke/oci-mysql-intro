
module "db" {
    source              = "./modules/db"

    db_password_base64  = data.oci_secrets_secretbundle.db_password.secret_bundle_content[0]["content"]
    avadom_name         = local.avadom_name
    compartment_ocid    = var.compartment_ocid
    subnet_ocid         = var.subnet_ocid
    shape_name          = var.db_shapes_map[var.db_cores]
}
