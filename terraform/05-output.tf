output "public_ip" {
  value = openstack_networking_floatingip_v2.float_ip.address
  sensitive=false
}

output "server_private_ip" {
  value = openstack_compute_instance_v2.server.access_ip_v4
  sensitive=false
}


