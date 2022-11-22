# Erster Login und SSH public Key Import

## Login

* Rufe die URL https://cloud.syseleven.de im Browser auf

<img src="https://docs.syseleven.de/syseleven-stack/user/pages/images/horizon-login.png"/>

* melde dich mit deinen Zugangsdaten an
  * Domain: `default`
  * User Name: `<Benutzername>`
  * Password: `<Passwort>`
* Klick auf "CONNECT"

## SSH public Key importieren
* Um deinen SSH Key zu importieren, klick auf "Compute" --> "Key Pairs"
* Wähle "Import Public Key" aus und 
  * gib dem Key im Feld "Key Pair Name" den Namen `demokey` und
  * füge den public Key in das Feld "Public Key" ein
  * klick auf "Import Key Pair"

<img src="https://docs.syseleven.de/syseleven-stack/user/pages/images/sshkeys.png"/>
