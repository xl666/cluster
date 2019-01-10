#!/bin/sh


rsync -avz -e "ssh -p $REMOTE_PORT" "$RESPAL_DIR/" $REMOTE_USER@$REMOTE_SERVER:"$REMOTE_DIR/" #importante slash al final para no crear otro directorio
