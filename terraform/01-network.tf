
data "openstack_networking_network_v2" "public_network" {
  name = var.external_network_used
}


# Create network
resource "openstack_networking_network_v2" "network" {
  name           = "networkA1"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "subnet" {
  name       = "subnetA1"
  network_id = "${openstack_networking_network_v2.network.id}"
  cidr       = var.subnetwork_cidr
  ip_version = 4
}

resource "openstack_networking_router_v2" "router" {
  name                = "routerA1"
  admin_state_up      = true
  external_network_id = data.openstack_networking_network_v2.public_network.id
    depends_on = [openstack_networking_network_v2.network]
}


resource "openstack_networking_router_interface_v2" "router_interface" {
  router_id = openstack_networking_router_v2.router.id
  subnet_id =openstack_networking_subnet_v2.subnet.id
}


resource "openstack_networking_port_v2" "port_webapp" {
  name           = "port_webapp"
  network_id     = openstack_networking_network_v2.network.id
  admin_state_up = "true"

  security_group_ids = [openstack_networking_secgroup_v2.ssh.id, openstack_networking_secgroup_v2.application.id]
  depends_on = [ openstack_networking_subnet_v2.subnet ]
}

resource "openstack_networking_port_v2" "port_backend" {
  name           = "port_backend"
  network_id     = openstack_networking_network_v2.network.id
  admin_state_up = "true"

  security_group_ids = [openstack_networking_secgroup_v2.ssh.id, openstack_networking_secgroup_v2.application.id]
  depends_on = [ openstack_networking_subnet_v2.subnet ]
}

#https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/networking_secgroup_v2
resource "openstack_networking_secgroup_v2" "sg_webapp" {
  name        = "sg_webapp"
  description = "SSH sec group for automatic deployment"
}

resource "openstack_networking_secgroup_rule_v2" "webapp_ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.webapp.id
}

resource "openstack_networking_secgroup_rule_v2" "webapp_app" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = var.webapp_port
  port_range_max    = var.webapp_port
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.webapp.id
}

resource "openstack_networking_secgroup_v2" "database" {
  name = "sg_database"
}