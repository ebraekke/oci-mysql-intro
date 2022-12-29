
/*
module "lbr" {
    source              = "./modules/lbr"

    compartment_ocid    = var.compartment_ocid
    ssh_public_key      = var.ssh_public_key
    user_data_base64    = local.user_data_base64_standard
    shape               = var.lbr_shape
    ocpus               = var.lbr_ocpus
    memory_in_gbs       = var.lbr_mem_per_ocpu * var.lbr_ocpus
    avadom_name         = local.avadom_name
    subnet_ocid         = var.lbr_subnet_ocid
    image_ocid          = var.lbr_image_ocid
}

module "worker" {
    source              = "./modules/worker"

    instance_count      = var.worker_count
    compartment_ocid    = var.compartment_ocid
    ssh_public_key      = var.ssh_public_key
    user_data_base64    = local.user_data_base64_standard
    shape               = var.worker_shape
    avadom_name         = local.avadom_name
    faldom_list         = local.faldom_list 
    faldom_count        = local.faldom_count 
    subnet_ocid         = var.worker_subnet_ocid
    image_ocid          = var.worker_image_ocid
}
*/