#!/bin/bash

# =======================================================================================
# DESCRIPCION
# - Elimina los ficheros fuente del dia actual menos 14 dias.
# - En el caso de que el dia actual sea viernes, antes de eliminarlo crea un comprimido con los ficheros fuente.
# - Comprime y elimina la carpeta del dia actual menos 28 dias.
#
# COMANDOS UTILES
#   -z: Comprimirlo con gzip
#   -c: Crear un archivo
#   -f: Especificar el nombre del archivo
#   -C: Cambiar el directorio antes de realizar cualquier operacion
#   -t: Listar contenido
#   -x: Extraer ficheros
#
# Comprimir:                    tar -zcf /home/user/fuente.tar.gz -C /home/user/fuente .
# Descomprimir un fichero:      tar -zxf huawei.tar.gz
# Ver contenido de un tar.gz:   tar -tf huawei.tar.gz
#
# EJEMPLO
# 00 02 * * *  /home/administrador/scripts/borrar_exports.sh
# =======================================================================================

PATH_EXPORTS=/mnt/serv_datos/DATOS_COMPARTIDOS

YEAR=$(date -d -14day +%Y)
MONTH=$(date -d -14day +%m_%B)
DAY=$(date -d -14day +%Y%m%d)
DAY_OF_WEEK=$(date -d -14day +%u)

PATH_SOURCES=("$PATH_EXPORTS/vendor/exports/$YEAR/$MONTH/$DAY/red_propia"
              "$PATH_EXPORTS/vendor/exports/$YEAR/$MONTH/$DAY/ran_sharing")

YEAR_LAST=$(date -d -28day +%Y)
MONTH_LAST=$(date -d -28day +%m_%B)
DAY_LAST=$(date -d -28day +%Y%m%d)

PATHS_BY_DAY=("$PATH_EXPORTS/vendor/exports/$YEAR_LAST/$MONTH_LAST"
              "$PATH_EXPORTS/vendor/exports/$YEAR_LAST/$MONTH_LAST")


# Comprimo y/o borro fuentes
for path in ${PATH_SOURCES[*]}; do
    if [ "$DAY_OF_WEEK" -eq 5 ]
    then
        tar -zcf "$path"/fuente.tar.gz -C "$path" ./fuente
    fi
    rm -rf "$path"/fuente
done

# Comprimir por dia
for path in ${PATHS_BY_DAY[*]}; do
    tar -zcf $path/$DAY_LAST.tar.gz -C $path ./$DAY_LAST
    rm -rf $path/$DAY_LAST
done
