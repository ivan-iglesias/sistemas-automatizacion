#!/bin/bash

# =======================================================================================
# DESCRIPCION
# Borra los ficheros con mas de 5 dias que se encuentran en el directorio indicado.
#
# COMANDO FIND
#    mtime: +30 seria mas viejo de 30 dias, -30 modificado en los ultimos 30 dias.
#    -type f: Busca ficheros, con 'd' serian directorios. Si no se especifica los dos.
#
# EJEMPLO
# 00 01 * * *  /home/administrador/scripts/borrar_temporal.sh
# =======================================================================================

PATHS="/mnt/serv_datos/TEMPORAL"

for path in $PATHS/*; do
    find $path/* -mtime +5 -exec rm -r {} \;
done
