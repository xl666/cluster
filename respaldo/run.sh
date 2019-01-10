#!/bin/sh

# determina si un directorio esta vacio o no existe
function estaVacioONoExiste() {
    [[ -z "$(ls $1 2> /dev/null)" ]] && echo "1" || echo ""
}

# restaurar un respaldo si se activo la opcion y $RESPAL_DIR no esxite o esta vacio
resultado=$(estaVacioONoExiste "$RESPAL_DIR")
[[ $RESTORE ]] && [[ $resultado ]] && {
    rsync -avz -e "ssh -p $REMOTE_PORT" $REMOTE_USER@$REMOTE_SERVER:"$REMOTE_DIR/" "$RESPAL_DIR/" || {
	echo "No se pudo restaurar el respaldo, asegurate de que $REMOTE_DIR exista y sea accesible en el servidor remoto $REMOTE_SERVER";
	exit 1;
    };
    echo "Restauracion exitosa"
    exit 0; # no hacer nadamas
}

# Se activo la opcion pero el directorio existe y no esta vacio
[[ $RESTORE ]] && {
    echo "El directorio $RESPAL_DIR no debe existir o debe estar vacio";
    exit 1;
}

#Asegurarse de que el directorio remoto exista y no sea un archivo

ssh -p $REMOTE_PORT $REMOTE_USER@$REMOTE_SERVER mkdir -p $REMOTE_DIR || {
    echo "$REMOTE_DIR es un archivo y no un directorio en el servidor remoto";
    exit 1;
}

# Se activa el respaldo periodico
echo "Iniciando respaldo periodico"
echo "$CRONSTRING /respaldar.sh" | crontab - && crond -f -L -
