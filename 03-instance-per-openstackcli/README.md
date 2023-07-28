# Creating an instance via Openstack client

## Overview

With this guide you can create a single instance via the Openstack client.

## Goal

* Create a single instance via Openstack client

## Preparation

* You need your Openstack credentials
  * Username
  * Password
  * Project ID
  * Region name
* basic knowledge of using a Linux terminal and SSH
* previously installed jumphost from lab [01-erster-login-und-jumphost](/01-erster-login-und-jumphost)

---

### Start

* Log into the jumphost from lab [01-erster-login-und-jumphost](/01-erster-login-und-jumphost) ein

`ssh syseleven@<Jumphost-IP> -A -i /path/to/private-key`

---

### Collect information about existing infrastructure

To integrate a new instance into the existing network topology we first need an overview
over the current components.

Obtain information with the following commands.

* print a list of available **Flavors**

`openstack flavor list`

* display existing operating system **Images**

`openstack image list`

* look for the **Network** the new instance should be placed in

`openstack network list`

* print the **Security Groups**

`openstack security group list`

* look for the existing SSH **Key Pairs**

`openstack keypair list`

---

### Creating a new instance

Now we create a new instance directly with Openstack client commands. 
Enter the previously collected information into the following lines.

```
openstack server create \
  --flavor "<REPLACE>" \
  --image "<REPLACE>" \
  --network "<REPLACE>" \
  --security-group "<REPLACE>" \
  --key-name "<REPLACE>" \
  server-cli
```

Example:

* This is just an example! Below entries, IDs and names will be different on your machine!  

```
openstack server create \
  --flavor "m1.tiny" \
  --image "Ubuntu Focal 20.04 (2022-11-29)" \
  --network "workshop-kickstart-net" \
  --security-group "abad8853-af7c-4e92-8afc-4ea6316dbb15" \
  --key-name "workshop" \
  server-cli
```

---

### Verify the setup

Now we verify the current state of the instance

* Display all instances

`openstack server list`

* Display instance details

`openstack server show server-cli`

#### What did you notice?

* the instance has no public IP address

### Login

* Use the jumphost to log in to the instance:

`ssh ubuntu@<internal-IP>`

* we need to use the username "ubuntu", because the cloud-image of Ubuntu requires it

#### Other tasks:

* display the instance in Horizon (GUI)
* check if the instance appears in the graphical network topology
* display the security groups assigned to the instance in Horizon
