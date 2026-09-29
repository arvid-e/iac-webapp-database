output "public_ip" {
  value = openstack_networking_floatingip_v2.float_ip.address
  sensitive=false
}

output "webapp_private_ip" {
  value = openstack_compute_instance_v2.webapp.access_ip_v4
  sensitive=false
}

output "database_private_ip" {
  value = openstack_compute_instance_v2.database.access_ip_v4
  sensitive=false
}

