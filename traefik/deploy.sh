#!/bin/bash

# se crea la red si no existe
docker network create --opt encrypted --driver=overlay --attachable proxy 2> /dev/null

docker service create --mount src=/var/run/docker.sock,dst=/var/run/docker.sock,type=bind --mount src=/mnt/ceph/traefik/traefik.toml,dst=/traefik.toml,type=bind   --mount src=/mnt/ceph/traefik/certs,dst=/certs,type=bind   -p published=80,target=80   -p  published=443,target=443   -l traefik.frontend.rule=Host:xavierlimon.com   -l traefik.port=8080 -l traefik.docker.network=proxy --mode global --constraint node.role==manager    --name traefik --network proxy traefik --docker --web  --docker.watch --docker.swarmMode --docker.domain=xavierlimon.com
