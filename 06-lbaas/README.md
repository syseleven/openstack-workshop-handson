# Webserver with loadbalancer

## Overview

With this guide you can deploy a simple web application and publish it through a loadbalancer.

## Goal

* create two webservers with a simple web application
* the application will be served behind a loadbalancer and you can request it by a public IP address

## Preparation

* You need your credentials for Openstack
  * Username
  * Password
  * Project ID
  * Region name
* Web browser

---

### Login

* Visit URL https://cloud.syseleven.de

* log in with your credentials
  * Domain: `default`
  * User Name: `<Benutzername>`
  * Password: `<Passwort>`
* Click "CONNECT"

![](images/001-login-window.png)

### Select region

* First check if you have set the correct region. If not please change region.

![](images/002-select-region.png)

### Start Heat Stack

* Click "Project" --> "Orchestration" --> "Stacks" to create the demo stack in Horizon
* click "Launch Stack"

![](images/003-orchestration-stacks.png)

![](images/04-select-stack-template.png)

---

* Select `URL` as a **Template Source**
* Copy the URL of the demo stack (1 long line!)

`https://raw.githubusercontent.com/syseleven/openstack-workshop-lab/main/06-lbaas/lbstack.yaml`

* and paste it into the field **Template URL**
* Select `File` as **Environment Source**
* click **NEXT**

---

* in the field **Stack Name** enter `webserver` as a name
* edit the following fields:
* enter your OpenStack password in the field **Password for user...**
* select as a **flavor** `m1.tiny`
* select an arbitrary `Ubuntu Focal 20.04 ...` **image**
* select the existing SSH key for **key_name**
* click the button **LAUNCH**

![](images/005-launch-webserver-stack.png)

---

### Setup of the loadbalancer stack

The Heat Stack consists of a loadbalancer and webservers and is now being created.
The progress can be followed by clicking the stack name.

![](images/006-webserver-stack-complete.png)

---

![](images/007-webserver-stack-topology.png)

---

AS soon as all components are displayed green they can be selected and observed.

* for example the both webserver instances under **Compute** --> **Instances**
* they are named `upstream0` and `upstream1`

![](images/008-webserver-instances.png)

---

The loadbalancer was also created and can be observed under **Network** --> **Octavia Load Balancers**

![](images/009-webserver-loadbalancer.png)

* click the name of the loadbalancer to display its public IP address
* use the IP to visit the demo application in your web browser: `http://<Loadbalancer-IP>`


![](images/010-loadbalancer-public-ip.png)

---

#### Goal

* refresh the website in your browser several times
* Result: the content of the page displays the names of both webservers serving the web content
* this means the loadbalancer fulfills its task

`upstream0` -> `upstream1` -> `upstream0` and so on...

---

#### Other tasks

The loadbalancer itself contains several sub-components:

* Listener
* Pools
* Health Monitors
* Members

* display thoses components in Horizon and verify they are in state `online`
