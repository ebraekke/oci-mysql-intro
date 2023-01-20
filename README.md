# ebraekke/oci-mysql-intro

# Intro 

This is the first version of a terraform recipe that creates a MySQL DB System (aka InnoDB Cluster) inside a 
private subnet in a VCN. 

It creates a HA config of a MySQL DB System as well as a corresponding connection object. 

HA in this context means three nodes spread across three ADs (Availability Domains or Zone) if in a multi AD region.
In the case of single AD region, the three nodes are spread across FDs (Fault Domains) -- technically, entirely separate cages inside a DC.   

The recipe assumes a fairly basic network setup. 
I use a default VCN created by the wizard. 
* Netmask for VCN: `10.0.0.0/16`
* Netmask for public subnet: `10.0.0.0/24`
* Netmask for private subnet: `10.0.1.0/24`

In my reference network I only allow traffic on SSH (port 22) and MySQL (3306) from a Bastion's private IP that 
has been created in my public subnet. This means traffic through the Bastion is the only traffic allowed into the network. 

## Required input parameters 

```hcl
variable "subnet_ocid"          {
    description = "ocid of (private) subnet to host InnoDB cluster"
}

variable "password_ocid" {
    description = "ocid of secret in vault"  
}

variable "priv_endpoint_ocid" {
    description = "ocid of private endpoint in \"subnet_ocid\" to be used by new connection" 
}

variable "db_cores" {
    description = "Number of Cores per InnoDB node, index of db_shapes_map below"
    default = "1"
}
```

## Calculated values

The parameter value of `db_cores` is used to select the appropriate shape.

```hcl
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
```

## Default parameters

The following "default" parameters need to be provided to the oci terraform provider. 

```hcl
variable "region"               { default = "eu-frankfurt-1"}
variable "tenancy_ocid"         {}
variable "compartment_ocid"     {}
variable "user_ocid"            {}
variable "fingerprint"          {}
variable "private_key_path"     {}
```

## Outputs

The created Connection resource contains all the information needed access the DB  system.

```bash
Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:

conn_ocid = "ocid1.databasetoolsconnection.oc1.eu-frankfurt-1.<some-secret-string>"
```


## Other 

The created config can be used by the repo `ebraekke/oci-powershell-modules` when connecting via mysqlsh.

## Usage

Store config files in sub-dir `config/` it is ignored by git.

```bash
terraform plan --out=oci-mysql-intro.tfplan --var-file=config/vars_fra.tfvars

terraform apply "oci-mysql-intro.tfplan"
```
