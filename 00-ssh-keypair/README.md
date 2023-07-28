# Add an SSH keypair

## Overview

With this guide you can add an SSH keypair to your Openstack project for SSH connections
on instances.

## Goal

* create a new SSH keypair via Horizon (GUI)
* import an existing SSH public key via Horizon (GUI)

## Preparation

* You need the login credentials for Openstack
  * Username
  * Password
  * Project ID
  * Region Name
* Web browser and basic knowledge using a Linux terminal and SSH

---

### Login

* Visit the URL https://cloud.syseleven.de

* log in with your credentials
  * User Name: `<Username>`
  * Password: `<Password>`
* click "Sign In"

![](images/01-login-window.png)

### Select region

* First check if you are logged in to the correct region and maybe switch region

![](images/02-select-region.png)

### Option 1 - Create SSH keypair

* click "Compute" --> "Key Pairs" to list existing SSH keys
* click "Create Key Pair"

![](images/03-create-key-pair-button.png)

![](images/04-create-keypair-name.png)

* Enter a `Key Pair Name` name for it and type `workshop`.
* As `Key Type` choose `SSH Key`
* click **Create Key Pair**

![](images/05-list-keypair.png)

* View the keypair details in the list.

---

### Option 2 - Import SSH keypair

* click "Compute" --> "Key Pairs" to list existing SSH keys
* click "Import Public Key"

![](images/06-import-public-key-button.png)

![](images/07-import-public-key-name.png)

* Enter a `Key Pair Name` name for it and type `workshop`.
* As `Key Type` choose `SSH Key`
* Optionally choose a file from your local machine or
* paste the public key into the textfield
* click **Import Key Pair**

![](images/05-list-keypair.png)

* View the keypair details in the list.
