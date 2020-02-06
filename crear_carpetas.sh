#!/bin/bash

# =======================================================================================
# DESCRIPCION
# Automatizar la creación de carpetas.
#
# EJEMPLO
# 10 00 * * * /home/administrador/scripts/crear_carpetas.sh
# =======================================================================================

YEAR=$(date +%Y)
MONTH=$(date +%m_%B)
DAY=$(date +%Y%m%d)

PATH_PROJECT=/mnt/serv_datos/PROYECTOS/

mkdir -p $PATH_PROJECT/vendor/exports/$YEAR/$MONTH/$DAY/
mkdir -p $PATH_PROJECT/vendor/alarmas/$YEAR/$MONTH/$DAY/

cd $PATH_PROJECT/vendor/exports/$YEAR/$MONTH/$DAY/
mkdir red_propia
mkdir red_propia/fuente
mkdir red_propia/eri_2g
mkdir red_propia/eri_2g/msc/
mkdir ran_sharing

cd $PATH_PROJECT/vendor/alarmas/$YEAR/$MONTH/$DAY/
mkdir 2g 3g 4g
