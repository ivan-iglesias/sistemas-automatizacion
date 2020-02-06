#!/bin/bash

# =======================================================================================
# DESCRIPCION
# Monitoriza que existan los ficheros indicados en el fichero pasado por argumento.
# En caso de que no exista alguno manda un correo a sistemas.
#
# CONFIGURACION
# En el fichero /etc/ssmtp/ssmtp.conf se introduce la cuenta y credenciales para mandar
# los correos.
#
# EJEMPLO
# 0 10 * * 1,2,3,4,5 /home/administrador/scripts/monitorizar.sh /home/administrador/scripts/monitorizar_rutas.txt
# =======================================================================================

YEAR=$(date +%Y)
MONTH=$(date +%m_%B)
DAY=$(date +%Y%m%d)
PATH_LOG=/home/administrador/scripts/monitorizar/email.txt

# Extraigo el nombre del fichero y lo paso a mayusculas
file_name=$(basename "$1" ".txt")
file_name="${file_name^^}"

# Cabecera y primera linea del correo a mandar
echo -e "To: sistemas@gmail.com\nFrom: notificaciones.sistemas@gmail.com\nSubject: $file_name" > $PATH_LOG
echo -e "\nNo se encuentran los siguientes ficheros:\n" >> $PATH_LOG

# Monitorizao las rutas
while read line; do
    path=$(eval echo $line)

    counter=$(ls 2>> $PATH_LOG -1q $path | wc -l)
    if [ "$counter" -eq 0 ]
    then
        echo -e "Empty: $path" >> $PATH_LOG
    fi
done < $1

# Si el fichero tiene mas de 6 lineas, es que falta algo en alguna de las rutas
counter=$(cat $PATH_LOG | wc -l)
if [ "$counter" -gt 6 ]
then
    /usr/sbin/ssmtp sistemas@gmail.com < $PATH_LOG
fi
