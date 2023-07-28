# Create and mount a volume with Horizon

## Overview

With this guide you can create a volume in Horizon and mount it to an instance.

## Goal

* Create a volume in Horizon
* create a file system on the volume
* mount the volume on an instance

## Preparation

* You need your Openstack credentials
  * Username
  * Password
  * Project ID
  * Region name
* Previously installed installed from task [02-instance-per-horizon](/02-instance-per-horizon)

---

## Start

* Log in at https://cloud.syseleven.de Horizon Web UI with you credentials

![](images/001-login-windows.png)

* check if you have selected the correct region. if not please switch region.

![](images/002-select-region.png)

---

### Create volume

* Click **Project** --> **Volumes** --> **Volumes**
* click the button **CREATE VOLUME**

![](images/003-button-create-volume.png)

* under **Volume Name** enter `workshop`
* optionally add a **Description**
* select as **Volume Source** `NO SOURCE, EMPTY VOLUME`
* set **Type** to `QUOBYTE`
* enter a **Size (GiB)** of `1`
* under **Availability Zone** select the assigned **Region**
* click **CREATE VOLUME**

![](images/010-create-volume.png)

---

* the volume will now be created and appears in the list

![](images/011-volume-created.png)

#### What did you notice?

* the volume is in state "available", because it is not yet attached to an instance

---

### Attach a volume to an instance

To attach the newly created volume to an instance and to use it there, do:

* click **Compute** --> **Instances**
* select the action **ATTACH VOLUME** next to the instance (server-horizon oder server-cli)

![](images/020-action-attach-volume.png)

* as **Volume ID** select the previously created volume identified by its name or ID
* click **ATTACH VOLUME**

![](images/030-attach-volume.png)

---

#### What did you notice?

* the volume is displayed as state "in-use"
* this means it is now attached to an instance

---

### Mounting a volume in an instance

* use the jumphost to log in to the instance the volume is attached to

`ssh ubuntu@<Instance-IP>`

* check if the operating system of the instance has found volume as a new device
* 
* volumes are named in alpabetical order like `/dev/vd[a-z]` and this action is logged in the system log

```
dmesg

[  511.161272] virtio-pci 0000:00:07.0: enabling device (0000 -> 0003)
[  511.194305] virtio_blk virtio4: [vdb] 2097152 512-byte logical blocks (1.07 GB/1.00 GiB)
```

* next to the partitions of the OS (`vda`) also the new volume is displayed (`vdb`)

* still it does not contain a filesystem or partitions

```
lsblk -o NAME,FSTYPE,LABEL,SIZE,MOUNTPOINT

NAME    FSTYPE   LABEL            SIZE MOUNTPOINT
[...]
vda                                50G 
├─vda1  ext4     cloudimg-rootfs 49.9G /
├─vda14                             4M 
└─vda15 vfat     UEFI             106M /boot/efi
vdb                                 1G
```

* to mount the volume you need to create a file system, for example ext4:

```
sudo mkfs.ext4 /dev/vdb
```

* then the filesystem is displayed:

```
lsblk -o NAME,FSTYPE,LABEL,SIZE,MOUNTPOINT

NAME    FSTYPE   LABEL            SIZE MOUNTPOINT
[...]
vda                                50G 
├─vda1  ext4     cloudimg-rootfs 49.9G /
├─vda14                             4M 
└─vda15 vfat     UEFI             106M /boot/efi
vdb     ext4                        1G
```

* now we can mount the volume to directory /mnt

```
sudo mount -t auto -v /dev/vdb /mnt
```

* the volume now shows up in the file structure of the operating system:

```
df -h

Filesystem      Size  Used Avail Use% Mounted on
[...]
/dev/vdb        974M   24K  907M   1% /mnt
```

* we can now write data to it:

`sudo touch /mnt/hello.txt`

---

* optionally we can unmount it again:

```
sudo umount /mnt
```

### Result

* the volume can now store persistent data
* volumes can be attached to another instance
* multi-attach volumes are also possible with a special file system
