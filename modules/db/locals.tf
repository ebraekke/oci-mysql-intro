
# generate password, this resource creates warnings if you try to output 
resource "random_password" "_password" {

  # https://docs.oracle.com/en-us/iaas/Content/Identity/Tasks/managingpasswordrules.htm
  length           = 16
  special          = true
  override_special = "!#$%&'()*+,-./:;<=>?@[\\]^_`{|}~"
  min_lower        = 1
  min_upper        = 1
  min_numeric      = 1
  min_special      = 1
}

# variables for readability in complex statements
locals {

    # get password once
    password = random_password._password.result
}
