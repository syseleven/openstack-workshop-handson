# Creating an instance with Terraform

## Overview

With this guide you can create a single instance with Terraform.

## Goal

* Create a single instance with Terraform automation

## Preparation

* You need your Openstack credentials
  * Username
  * Password
  * Project ID
  * Region name
* basic knowledge of using a Linux terminal and SSH
* previously installed jumphost from lab [01-erster-login-und-jumphost](/01-erster-login-und-jumphost)

---

### Clone source code

* Connect with your jumphost from the previous lab
* for the following steps you need the files from this repository, so you need to clone it to your jumphost:
  * execute this command: `git clone https://github.com/syseleven/openstack-workshop-lab.git`
  * Change the directory for the following tasks: `cd openstack-workshop-lab/04-instance-per-terraform`

### Activate environment for the Openstack client

* **Notice:** If you use the same SSH session from the previous lab you may skip this step.
* If you just created a new SSH session to the jumphost, you need to source the RC-file again to be able to use the Openstack client:
  * `source /home/syseleven/myopenrc`
  * Answer the interactive prompt

### Obtain IMAGE_ID parameter for the instance

Terraform asks for a parameter `IMAGE_ID` which we obtain by:

* Execute the following command: `openstack image list`
* Look in the output for the current `Ubuntu 20.04 ...` Image and copy its ID, for example:

Example:

* This is just an example! Below values will be different in you setup.

```plain
+--------------------------------------+----------------------------------+--------+
| ID                                   | Name                             | Status |
+--------------------------------------+----------------------------------+--------+
<...>
| 5809b59b-d8c3-459a-9666-6e21c905736b | Ubuntu Focal 20.04 (2022-11-29)  | active |
<...>
+--------------------------------------+----------------------------------+--------+
```

### Obtain SECGROUP_ID parameter for the instance

Terraform asks for a paremeter `SECGROUP_ID` which we obtain by:

* execute this command: `openstack security group list`
* in the output look for a security group with the name `workshop-kickstart-allow ...` and copy its ID

Example:

* This is just an example. Your settings will look different.

```plain
+--------------------------------------+-----------------------------------------------------------------+----------------------------------------------------+----------------------------------+------+
| ID                                   | Name                                                            | Description                                        | Project                          | Tags |
+--------------------------------------+-----------------------------------------------------------------+----------------------------------------------------+----------------------------------+------+
<...>
| ccceaba9-8413-4cf4-8c67-84bc425afe53 | workshop-kickstart-allow incoming traffic, tcp port 22 and icmp | allow incoming SSH and ICMP traffic from anywhere. | 7f1b76e71afb4749b852f04740e1af09 | []   |
<...>
+--------------------------------------+-----------------------------------------------------------------+----------------------------------------------------+----------------------------------+------+
```

### Set parameters for the instance

* open the file `instance.tf` with an editor: `vi instance.tf`
* Adjust the settings (marked with CAPS):
  * `INSTANCE_NAME` - plain text, instance name
  * `IMAGE_ID` - ID, see previous step
  * `FLAVOR_NAME` - valid Openstack flavor, set: `m1.tiny`
  * `KEYPAIR_NAME` - valid Openstack keypair name, here: `workshop`
  * `NETWORK_NAME` - name of existing network: `workshop-kickstart-net`
  * `SECGROUP_ID` - ID of the security group, see previous step
* Result:

Example:

* This is just an example. Your settings will look different.

```tf
resource "openstack_compute_instance_v2" "simple_instance" {
  name            = "Test Instance"
  image_id        = "5809b59b-d8c3-459a-9666-6e21c905736b"
  flavor_name     = "m1.tiny"
  key_pair        = "workshop"
  security_groups = ["ccceaba9-8413-4cf4-8c67-84bc425afe53"]

  network {
    name = "workshop-kickstart-net"
  }
}

resource "openstack_networking_floatingip_v2" "fip_simple_instance" {
  pool = "ext-net"
}

resource "openstack_compute_floatingip_associate_v2" "fipas_simple_instance" {
  floating_ip = openstack_networking_floatingip_v2.fip_simple_instance.address
  instance_id = openstack_compute_instance_v2.simple_instance.id
}
```

### Create instance with Terraform

* initialize the Terraform project locally initialisieren: `terraform init`
* check what Terraform would do: `terraform plan`
* create the instance with Terraform: `terraform apply`
* confirm final prompt with `yes`

### Verify

* display the instance in Horizon and connect via SSH and your private key
* **use the internal IP address** and username: `ubuntu`

`ssh ubuntu@<Floating IP>`

### Cleanup

* have Terraform remove the resources created before: `terraform destroy`
  * confirm final prompt with `yes`
