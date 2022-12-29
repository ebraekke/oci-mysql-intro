
module "db" {
    source              = "./modules/db"

    avadom_name         = local.avadom_name
    compartment_ocid    = var.compartment_ocid
    subnet_ocid         = var.subnet_ocid
    shape_name          =  var.db_shapes_map["1"]
}
