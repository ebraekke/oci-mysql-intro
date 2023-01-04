
/* uncomment for debugging -- not needed otherwise

output "ads" {
  value = data.oci_identity_availability_domains.ads
}

output "vcn_name" {
  value = data.oci_core_vcn.this_vcn.dns_label
}
*/

output "db_private_ip" {
  value = module.db.db_private_ip
}

output "db_ocid" {
  value = module.db.db_ocid
}

output "conn_ocid" {
  value = module.conn.conn_ocid
}
