# Erstellen und Mounten eines Volumes per Horizon

## Übersicht

Mit dieser Anleitung kannst Du Volumes per Horizon Web UI erstellen und in einer Instance mounten.

## Ziel

* Erstelle eine Volume mittels Horizon Web UI
* erstelle ein Filesystem auf dem Volume
* mounte das Volume in einer Instance

## Vorbereitung

* Du brauchst die Login Daten für Openstack
  * Benutzername
  * Passwort
  * Project ID
  * Region Name
* Bereits installierte Instance aus Aufgabe [02-instance-per-horizon](/02-instance-per-horizon)

---

## Start

* Log dich auf https://cloud.syseleven.de in die Horizon Web UI mit deinen Zugangsdaten ein

![](images/001-login-windows.png)

* überprüfe deine aktuelle Region und wechsle ggf. auf die korrekte Region

![](images/002-select-region.png)

---

```
dmesg
[  511.161272] virtio-pci 0000:00:07.0: enabling device (0000 -> 0003)
[  511.194305] virtio_blk virtio4: [vdb] 2097152 512-byte logical blocks (1.07 GB/1.00 GiB)

```

```
lsblk -o NAME,FSTYPE,LABEL,SIZE,MOUNTPOINT

NAME    FSTYPE   LABEL            SIZE MOUNTPOINT
loop0   squashfs                 63.2M /snap/core20/1695
loop1   squashfs                 49.7M /snap/snapd/17576
loop2   squashfs                 91.8M /snap/lxd/23991
vda                                50G 
├─vda1  ext4     cloudimg-rootfs 49.9G /
├─vda14                             4M 
└─vda15 vfat     UEFI             106M /boot/efi
vdb                                 1G
```

```
sudo mkfs.ext4 /dev/vdb
```

```
lsblk -o NAME,FSTYPE,LABEL,SIZE,MOUNTPOINT

NAME    FSTYPE   LABEL            SIZE MOUNTPOINT
loop0   squashfs                 63.2M /snap/core20/1695
loop1   squashfs                 49.7M /snap/snapd/17576
loop2   squashfs                 91.8M /snap/lxd/23991
vda                                50G 
├─vda1  ext4     cloudimg-rootfs 49.9G /
├─vda14                             4M 
└─vda15 vfat     UEFI             106M /boot/efi
vdb     ext4                        1G
```

```
sudo mount -t auto -v /dev/vdb /mnt
```

```
df -h

Filesystem      Size  Used Avail Use% Mounted on
[...]
/dev/vdb        974M   24K  907M   1% /mnt
```

```
sudo umount /mnt
```
