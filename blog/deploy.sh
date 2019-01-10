#!/bin/bash

# Script para desplegar wordpress
# No se puso en un solo yaml ya que mariadb debe haber iniciado
# correctamente antes de iniciar wordpress
# este script hace un health check de mariadb

# Intentar crear red wordpress

docker network create --opt encrypted -d overlay wordpress 2> /dev/null

docker stack deploy -c docker-composeBD.yaml wordpressBD

while [ 1 ]; do
    sleep 2;
    docker service logs --tail 2 wordpressBD_db 2>&1 | grep "ready for connections"
    [[ $? -eq 0 ]] && break
done

docker stack deploy -c docker-composeWP.yaml wordpress
