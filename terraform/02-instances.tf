resource "openstack_compute_instance_v2" "backend" {
  name              = "backend"
  flavor_name       = var.flavor_name
  key_pair          = var.key_name
  image_name        = var.backend_image_name
  availability_zone = var.availability_zone
  depends_on = [
    openstack_networking_router_interface_v2.router_interface,  openstack_networking_network_v2.network, openstack_networking_secgroup_v2.ssh, openstack_networking_port_v2.the_port
  ]
  network {
    port = openstack_networking_port_v2.port_backend.id
  }
}

resource "openstack_compute_instance_v2" "webapp" {
  name              = "webapp"
  image_name        = var.webapp_image_name
  flavor_name       = var.flavor_name
  key_pair          = var.key_name
  availability_zone = var.availability_zone

  network {
    port = openstack_networking_port_v2.port_webapp.id
  }
}