resource "openstack_compute_instance_v2" "database" {
  name              = "database"
  flavor_name       = var.flavor_name
  key_pair          = var.key_name
  image_name        = var.database_image_name
  availability_zone = var.availability_zone
  
  network {
    port = openstack_networking_port_v2.port_database.id
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