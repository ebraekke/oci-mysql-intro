
# variables 
variable "subnet_ocid"          {}

# variables for all instances 
variable "ssh_public_key"       {}

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
# Details related to account/identity (provider.tf)
###########################################################################
variable "region"               { default = "eu-frankfurt-1"}
variable "tenancy_ocid"         {}
variable "compartment_ocid"     {}
variable "user_ocid"            {}
variable "fingerprint"          {}
variable "private_key_path"     {}
