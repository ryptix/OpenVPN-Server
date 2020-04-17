# OpenVPN-Server
OpenVPN Server which run in DOCKER

## Start-up
Copy the files in a directory, place yourself in a directory and simply : 
 > run docker-compose up --build
You can modify the docker-compose.yml as you please just mind the double space 

## Server Configuration
When you launch the docker for the first time it will create a server.conf with a basic configuration depending on the Environnement Variable you've set and depending on the default value.

If you want to further configure your server please edit the server.conf directly they will be used on the next restart. 

You can edit it like a standard OpenVPN Server every modification will be effective at the next restart.

## Env Variable
The **bold text** are the default value.

Please **don't put file extension** in the ENV variable.

* Mandatory
  * 
* Optional
  * **PORT**
    > Used to set the port for the VPN (**1194**)
  * **PROTO**
    > Used to set the protocol used (**Udp** or Tcp)
  * **DEV**
    > Used to set the type of device (**Tun** or Tap)
  * **OPENVPN_CA**
    > Used to set the name of the Certificate Authority (**ca.crt**)
  * **OPENVPN_KEY**
    > Used to set the name of the server key (**server.key**)
  * **OPENVPN_DH**
    > Used to set the name of the DH (**dh.pem**
  * **OPENVPN_AUTH**
    > Used to set the auth parameter in the server.conf (**SHA256**)
  * **OPENVPN_TA**
    > Used to set the name of the TA key (**ta.key**)
  * **OPENVPN_IP**
    > Used to set the IP of the VPN (**10.8.0.0**)
  * **OPENVPN_MASK**
    > Used to set the MASK of the VPN (**255.255.255.0**)
  * **PERSIST**
    > Used to set the IP given to client to persistant (**true** or false)
  * **LOG**
    > Used to activate the LOG on the server (**true** or false)
  * **VERB**
    > Used to set the verbosity of the server in LOG (**3** or 6 or 9) 9 is the highest.
  * **EXPLICIT_EXIT**
    > Used to tell the user when the server is restarting (**true** or false) (Not usable with TCp)
  * **CCD**
    > Used to create a CCD directory to create per user configuration (**false** or true)
  * **REDIRECT_ALL**
    > Used to redirect all-traffic from the client to the server (**false** or true)
  * **CLIENT_TO_CLIENT**
    > Used to activate client-to-client configuration allowing client to see each others (**true** or false)
  * **CIPHER**
    > Used to set Ciphher in the server configuration (**AES-256-CBC**)

## How to reset the configuration

To reset the configuration you just need to delete all the file in data and restart the docker.
Please **move** the important file before suppression :
 * ta.key
 * ca.crt
 * server.crt
 * server.key
 * dh.pem
