
# Variables 
variable "set_name" {
    description = "The name of or role of this set, used as base for naming, typicall test/dev/qa"
}

variable "compartment_ocid"     {
    description = "ocid of compartment"
}

variable "vcn_ocid"             {
    description = "ocid of VCN" 
}

variable "subnet_ocid"          {
    description = "ocid of (private) subnet to host InnoDB cluster"
}

variable "vault_ocid" {
    description = "ocid of vault"
}

variable "db_user_name" {
    description = "name of admin db user"
    default = "admin"
}

variable "password_ocid" {
    description = "ocid of secret in vault"  
}

variable "priv_endpoint_ocid" {
    description = "ocid of private endpoint in \"vcn_ocid\" to be used by new connection" 
}

variable "db_cores" {
    description = "Number of Cores per InnoDB node, index of db_shapes_map below"
    default = "1"
}

variable "db_gb_storage" {
    description = "Number GB storage for InnoDB"
    default = "100"
}

variable "db_shapes_map"  {
    type = map
    default = {
        "1"  = "MySQL.VM.Standard.E4.1.16GB"
        "2"  = "MySQL.VM.Standard.E4.2.32GB"
        "4"  = "MySQL.VM.Standard.E4.4.64GB"
        "8"  = "MySQL.VM.Standard.E4.8.128GB"
        "16" = "MySQL.VM.Standard.E4.16.256GB"
        "24" = "MySQL.VM.Standard.E4.24.384GB"
        "32" = "MySQL.VM.Standard.E4.32.512GB"
        "48" = "MySQL.VM.Standard.E4.48.768GB"
        "64" = "MySQL.VM.Standard.E4.64.1024GB"
    }
}

###########################################################################
# Details related to account/identity (local_provider.tf) and book keeping
###########################################################################
variable "region"               {
    default = "eu-frankfurt-1"
}
variable "oci_cli_profile"      { 
    default = "nosefra"
    description = "name of oci cli profile used for session based auth"
}
variable "tenancy_ocid"         {}
