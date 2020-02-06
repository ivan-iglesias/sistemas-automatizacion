#!/bin/bash

# =======================================================================================
# DESCRIPCION
# Realiza copias de ficheros, eliminando las copias con más de un día de antiguedad.
# En la carpeta del proyecto hay que crear la carpeta "_bck".
#
# EJEMPLO
# 00 08-18 * * * /home/administrador/scripts/backup_ficheros.sh
# =======================================================================================

PATH_PRY=/mnt/serv_datos
DATE_TIME=$(date +%Y%m%d_%H%M)

# REHOMING
PATH_PROJECT=$PATH_PRY"/2020/Nombre-Proyecto"
cp "$PATH_PROJECT/100 Seguimiento/seguimiento_1.xlsx" "$PATH_PROJECT"/_bck/"$DATE_TIME""_seguimiento_1.xlsx.bak"
cp "$PATH_PROJECT/100 Seguimiento/seguimiento_2.xlsx" "$PATH_PROJECT"/_bck/"$DATE_TIME""_seguimiento_2.xlsx.bak"
find "$PATH_PROJECT"/_bck/* -name '*.bak' -mtime +1 -exec rm {} \;

