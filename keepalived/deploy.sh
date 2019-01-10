#!/bin/bash

function esNumero() {
    if [ $(echo $1 | egrep "^[0-9]+$") ]; then
	echo "1";
    else
	echo "";
    fi
}

[[ $1 ]] && [[ $(esNumero $1) ]] || {
    echo "Se esperaba un valor entero de prioridad, por ejemplo 200 o 100";
    exit 1;
    }


#Es necesario el modulo ip_vs cada vez que se reinicia
echo "modprobe ip_vs" >> /etc/rc.local
modprobe ip_vs

docker run -d --name keepalived --restart=always   --cap-add=NET_ADMIN --net=host   -e KEEPALIVED_UNICAST_PEERS="#PYTHON2BASH:['192.168.12.2', '192.168.12.47']"   -e KEEPALIVED_VIRTUAL_IPS=192.168.12.8   -e KEEPALIVED_PRIORITY=$1 -eKEEPALIVED_INTERFACE=enp0s3 osixia/keepalived:1.3.5
