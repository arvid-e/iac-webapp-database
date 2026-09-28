resource "openstack_networking_floatingip_v2" "float_ip" {
  
  pool = data.openstack_networking_network_v2.public_network.name
}


resource "openstack_networking_floatingip_associate_v2" "the_fip_association" {
  floating_ip = openstack_networking_floatingip_v2.float_ip.address
  port_id     = openstack_networking_port_v2.the_port.id
}
