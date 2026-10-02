
resource "local_file" "ansible_inventory"{
  content = templatefile("./templates/inventory.tmpl",
  {
    server_ip   = openstack_networking_floatingip_v2.float_ip.address
    database_ip = openstack_compute_instance_v2.database.access_ip_v4
    webapp_port = var.webapp_port
  }
  )
  filename = "../ansible/inventory"
}


resource "null_resource" "wait_ssh" {
 
  connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = "${file(var.identity_file)}"
    host     = openstack_networking_floatingip_v2.float_ip.address
  }
  provisioner "remote-exec" {
    inline = [
      "echo hello from `hostname`"
    ]
  }
    triggers = {
    always_run = "${timestamp()}"
  }
   depends_on = [local_file.ansible_inventory, openstack_compute_instance_v2.webapp, openstack_networking_router_interface_v2.router_interface]
}


resource "null_resource" "ansible-deploy" {

  depends_on = [
                 openstack_networking_floatingip_associate_v2.the_fip_association,
                 local_file.ansible_inventory,
                 openstack_compute_instance_v2.webapp,
                 openstack_compute_instance_v2.database,
                 null_resource.wait_ssh
                 ]

  triggers = {
    always_run = "${timestamp()}"
  }
  provisioner "local-exec" {
    command = "ansible-playbook -i ${var.ansible_files_relative_path}/inventory ${var.ansible_files_relative_path}/playbookA1.yml --extra-vars=\"ansible_ssh_private_key_file=${var.identity_file}\""

  }
}