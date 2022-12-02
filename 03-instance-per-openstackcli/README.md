# Erstellen einer Instance per OpenStack Client

## Übersicht

Mit dieser Anleitung kannst Du eine einzelne Instance per OpenStack Client erstellen.

## Ziel

* Erstelle eine Instance mittels OpenStack Befehlen

## Vorbereitung

* Du brauchst die Login Daten für OpenStack
  * Benutzername
  * Passwort
  * Project ID
  * Region Name
* Grundlegende Kenntnisse zum Umgang mit einem Linux Terminal und SSH
* Bereits installierte Jumphost VM aus Aufgabe [01-erster-login-und-jumphost](/01-erster-login-und-jumphost)

---

### Start

* Log dich auf dem Jumphost aus der Aufgabe [01-erster-login-und-jumphost](/01-erster-login-und-jumphost) ein

`ssh syseleven@<Jumphost-IP> -A -i /pfad/zum/private-key`

---

### Informationen zur vorhandenen Infrastruktur sammeln

Um die zu erstellende Instance in die vorhandene Netzwerktopologie zu integrieren,
brauchen wir zunächst einen Überblick über die bisherigen Komponenten.

Mit den folgenden Befehlen erhalten wir Informationen darüber.



* wir lassen uns eine Liste der verfügbaren **Flavors** ausgeben

`openstack flavor list`

* wir lassen uns die vorhandenen Betriebssystem-**Images** anzeigen

`openstack image list`

* wir suchen das **Netzwerk** in dem die neue Instance liegen soll

`openstack network list`

* wir lassen uns die **Security Groups** ausgeben

`openstack security group list`

* wir suchen die vorhandenen SSH **Key Pairs**

`openstack keypair list`

---

### Erstellen der neuen Instance

Nun erstellen wir direkt mit Befehlen des OpenStack Clients eine neue Instance. 
Trage in den folgenden Zeilen die zuvor gesammelten Informationen ein.

```
openstack server create \
  --flavor "<REPLACE>" \
  --image "<REPLACE>" \
  --network "<REPLACE>" \
  --security-group "<REPLACE>" \
  --key-name "<REPLACE>" \
  server-cli
```

Beispiel:

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

### Überprüfen des Setups

Nun überprüfen wir den Zustand der neuen Instance

* Anzeigen aller Instances

`openstack server list`

* Anzeigen der Instance Details

`openstack server show server-cli`

#### Was fällt auf?

* die Instance hat keine Public IP

### Login

* Login vom Jumphost aus:

`ssh ubuntu@<internal-IP>`

* wir müssen den Username "ubuntu" verwenden, weil dies so im Cloud-Image von Ubuntu festgelegt ist

#### Weitere Aufgaben:

* lasse dir die Instance in Horizon (GUI) anzeigen
* überprüfe, ob die Instance in der grafischen Netzwerk-Topologie auftaucht
* lasse die für die Instance gültige(n) Security Groups anzeigen (Horizon)
