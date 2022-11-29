# Erstellen einer Instance per Terraform

## Übersicht

Mit dieser Anleitung kannst Du eine einzelne Instance per Terraform erstellen.

## Ziel

* Erstelle eine Instance via Terraform-Automation

## Vorbereitung

* Du brauchst die Login Daten für Openstack
  * Benutzername
  * Passwort
  * Project ID
  * Region Name
* Grundlegende Kenntnisse zum Umgang mit einem Linux Terminal und SSH
* Bereits installierte Jumphost VM aus Aufgabe [01-erster-login-und-jumphost](/01-erster-login-und-jumphost)

---

### Sourcecode klonen

* Verbinde dich per SSH mit deiner Jumphost VM aus der vorherigen Aufgabe (wenn noch nicht geschehen)
* Für die folgenenden Schritte benötigst du die Dateien aus diesem Repository, daher musst du es auf deinem Jumphost klonen:
  * Führe das Kommando aus: `git clone https://github.com/syseleven/openstack-workshop-lab.git`
  * Wechsele in den richtigen Ordner für diese Aufgabe: `cd openstack-workshop-lab/02-instance-per-terraform`

### Umgebung für den Openstack Client aktivieren

* **Hinweis:** Solltest du die gleiche Session aus der vorherigen Aufgabe verwenden, kannst du diesen Schritt überspringen
* Wenn du eine neue Session auf dem Jumphost hast, musst du für die Verbindung zum Openstack wieder das RC-File sourcen:
  * `source /home/syseleven/myopenrc`
  * Interaktive Abfragen beantworten

### IMAGE_ID Parameter für die Instanz erhalten

Terraform möchte gleich gerne einen `IMAGE_ID` Parameter von uns haben, diesen besorgen wir uns wie folgt:

* Folgendes ausführen: `openstack image list`
* Suche im Output nach dem neuesten Ubuntu 20.04 Image und kopiere dir die ID, z.B.:

```plain
+--------------------------------------+----------------------------------+--------+
| ID                                   | Name                             | Status |
+--------------------------------------+----------------------------------+--------+
<...>
| 5809b59b-d8c3-459a-9666-6e21c905736b | Ubuntu Focal 20.04 (2022-11-29)  | active |
<...>
+--------------------------------------+----------------------------------+--------+
```

### Parameter für die Instanz anpassen

* Öffne die Datei `instance.tf` im Editor: `vi instance.tf`
* Passe die Werte in CAPS an:
  * `INSTANCE_NAME` - Freitext, Name der Instance
  * `IMAGE_ID` - ID, siehe vorheriger Schritt
  * `FLAVOR_NAME` - Gültiger Openstack Flavor, bevorzugt: `m1.tiny`
  * `KEYPAIR_NAME` - Gültiger Openstack Keypair Name, z.B. `...-workshop`
  * `NETWORK_NAME` - Name des bestehenden Netzes: `workshop-kickstart-net`
* Das Ergebnis sieht zum Beispiel so aus:

```tf
resource "openstack_compute_instance_v2" "simple_instance" {
  name            = "mmustermann test instance"
  image_id        = "5809b59b-d8c3-459a-9666-6e21c905736b"
  flavor_name     = "m1.tiny"
  key_pair        = "mmustermann_key"

  network {
    name = "workshop-kickstart-router"
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

### Instanz per Terraform ausrollen

* Zuerst checken, was Terraform tun würde: `terraform plan`
* Terraform die Instance ausrollen lassen: `terraform apply`
* Bei interaktiver Frage mit `yes` antworten

### Überprüfen

* Im Horizon Dashboard die Instanz suchen und mit SSH und Private Key mit der FloatingIP verbinden

### Aufräumen

* Terraform die erstellten Resourcen abbauen lassen: `terraform destroy`
* Auch hier bei interaktiver Frage mit `yes` antworten
