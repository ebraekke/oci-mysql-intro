# ebraekke/oci-mysql-intro

TODO: Modify to reflect new repos that have been published. 

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
I addition I allow MySQL database traffic (3306) from the two addresses of a private endpoint (aka "Reverse connection source IPs")
into the private subnet. This seems to be a prerequisite for making mysqlsh in CloudShell work.   

## Download the latest version of the Resource Manager ready stack from the releases section 

Or you can just click the button below. 

[![Deploy to Oracle Cloud](https://oci-resourcemanager-plugin.plugins.oci.oraclecloud.com/latest/deploy-to-oracle-cloud.svg)](https://cloud.oracle.com/resourcemanager/stacks/create?zipUrl=https://github.com/ebraekke/oci-mysql-intro/releases/download/v0.9.0-alpha.1/oci-mysql-intro_0.9.0.zip)


## Session based authentication 

Provide the name of the session created using `oci cli session autenticate` in the variable `oci_cli_profile`. 

## Required input parameters 

```hcl
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

variable "password_ocid" {
    description = "ocid of secret in vault"  
}

variable "priv_endpoint_ocid" {
    description = "ocid of private endpoint in \"vcn_ocid\" to be used by new connection" 
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

The following "default" parameters need to be passed to the oci terraform provider.

```hcl
variable "region"               { default = "eu-stockholm-1"}
variable "oci_cli_profile"      { 
    default = "nosearn"
    description = "name of oci cli profile used for session based auth"
}
variable "tenancy_ocid"         {}
```

## Outputs

The created Connection resource contains all the information needed access the DB  system.

```bash
Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:

conn_ocid = "ocid1.databasetoolsconnection.oc1.eu-stockholm-1.<some-secret-string>"
```


## Other 

The created config can be used by the repo `ebraekke/oci-powershell-modules` when connecting via mysqlsh.

## Usage

Store config files in sub-dir `config/` it is ignored by git.

```bash
terraform plan --out=oci-mysql-intro.tfplan --var-file=config/vars_arn.tfvars

terraform apply "oci-mysql-intro.tfplan"
```

## Resource Manager

### Create a release

Perform these operations from the top level folder in repo.

Remember to add Linux to lock file.
```bash
terraform providers lock -platform=linux_amd64
```

Create ZIP archive, add non-tracked file from config dir.
```bash
git archive --add-file config\provider.tf --format=zip HEAD -o .\config\test_rel.zip
```

### Create stack

```bash
$C = "ocid1.compartment.oc1..somehashlikestring"
$config_source = "C:\Users\espenbr\GitHub\oci-mysql-intro\config\test_rel.zip"
$variables_file = "C:/Users/espenbr/GitHub/oci-mysql-intro/config/vars_arn.json"
$disp_name = "Demo of MySQL InnoDB stack"
$desc = "InnoDB Cluster Creation from RM"
$wait_spec="--wait-for-state=ACTIVE"

oci resource-manager stack create --config-source=$config_source --display-name="$disp_name" --description="$desc" --variables=file://$variables_file -c $C --terraform-version=1.2.x $wait_spec
```

## List stacks in a compartment

Pwsh style quoting of strings. 

```bash
oci resource-manager  stack list -c $C --output table --query "data [*].{`"ocid`":`"id`", `"name`":`"display-name`"}"
<<
+----------------------------+------------------------------------------------------------------------------------------------+
| name                       | ocid                                                                                           |
+----------------------------+------------------------------------------------------------------------------------------------+
| Demo of MySQL InnoDB stack | ocid1.ormstack.oc1.eu-stockholm-1.somehashlikestring                                           |
+----------------------------+------------------------------------------------------------------------------------------------+
```

### Create plan job

```bash
oci resource-manager job create-plan-job --stack-id $stack_ocid --wait-for-state=SUCCEEDED --wait-interval-seconds=10
```

### Submit apply job job based on plan run 

Grab the job id from the output of the plan job.  

```bash
$plan_job_ocid = "ocid1.ormjob.oc1.eu-stockholm-1.somehashlikestring"

oci resource-manager job create-apply-job --execution-plan-strategy FROM_PLAN_JOB_ID --stack-id $stack_ocid --wait-for-state SUCCEEDED --wait-interval-seconds 10 --execution-plan-job-id $plan_job_ocid
```

### Create and run destroy job 

```bash
oci resource-manager job create-destroy-job --execution-plan-strategy AUTO_APPROVED  --stack-id $stack_ocid --wait-for-state SUCCEEDED --wait-interval-seconds 10
```

### Update variables 

```bash
oci resource-manager stack update --stack-id $stack_ocid --variables=file://C:/Users/espenbr/GitHub/oci-adb-intro/config/vars_fra.json
```

### Delete a specific stack 

```bash
oci resource-manager  stack delete --stack-id $stack_ocid --wait-for-state DELETED --wait-interval-seconds 10
```
