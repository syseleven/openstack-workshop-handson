resource "openstack_compute_instance_v2" "simple_instance" {
  name            = "INSTANCE_NAME"
  image_id        = "IMAGE_ID"
  flavor_name     = "FLAVOR_NAME"
  key_pair        = "KEYPAIR_NAME"
  security_groups = ["SECGROUP_ID"]
  
  network {
    name = "NETWORK_NAME"
  }
}

resource "openstack_networking_floatingip_v2" "fip_simple_instance" {
  pool = "ext-net"
}

resource "openstack_compute_floatingip_associate_v2" "fipas_simple_instance" {
  floating_ip = openstack_networking_floatingip_v2.fip_simple_instance.address
  instance_id = openstack_compute_instance_v2.simple_instance.id
}
