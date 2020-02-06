#!/bin/bash

# =======================================================================================
# DESCRIPCION
# Realiza copias de seguridad del servidor de datos en el siguiente orden:
#   Proyectos > BKP-1 > BKP-2
# Al realizar las copias no se eliminan los ficheros eliminados, a excepcion de los miercoles
# que se hace una actualizacion eliminando los fihceros que no existan en origen.
#
# OPCIONES RSYNC
#   -r: Aplica recursividad al origen de la copia.
#   -l: Conserva los enlaces simbolicos copiandolos como tales y apuntando al mismo destino.
#   -t: Conserva las fechas de modificacion.
#   -D: Copia dispositivos especiales.
#   -z: Aplica compresión a los datos durante la transferencia.
#   -v: verbose
#   -e: Permite especificar opciones al comando que usaremos de shell remota (ssh).
#   --delete: Borra los archivos en destino que no esten en origen.
#   --ignore-errors: Borra aunque haya fallos.
#   --exclude-from: Lee rutas excluidas de un fichero.
#   --stats: Estadisticas de los ficheros trasnferidos.
#   -n: Realiza una prueba sin realizar cambios (para testear).
#
# EJEMPLO
# 00 21 * * 1,2,3,4,5 /home/administrador/scripts/backup_servidor.sh
# =======================================================================================

DAY_OF_WEEK=$(date +%u)

SOURCE_USER=#USER_NAME
SOURCE_PASS=#USER_PASS
SOURCE_IP=#IP
SOURCE_PATH=#PATH

BKP_USER=#USER_NAME
BKP_PASS=#USER_PASS
BKP_IP=#IP
BKP_1_PATH=#PATH_AYER
BKP_1_LOG=/home/administrador/scripts/bkp-1.log
BKP_2_PATH=#PATH_ANTEAYER
BKP_2_LOG=/home/administrador/scripts/bkp-0.log

# Los miercoles borramos los ficheros eliminados en el servidor del backup
if [ "$DAY_OF_WEEK" -eq 3 ]
then
	RSYNC="/usr/bin/rsync -rltDz --delete --ignore-errors --stats -e"
else
	RSYNC="/usr/bin/rsync -rltDz --ignore-errors --stats -e"
fi

# Rsync de AYER a ANTEAYER (BCK-1 > BCK-2)
echo -e "To: sistemas@3dbconsult.com\nFrom: notificaciones.sistemas@3dbconsult.com\nSubject: Backup - Anteayer\n" > $BKP_2_LOG
$RSYNC 'sshpass -d 100 ssh -p 22' $BKP_1_PATH $BKP_USER@$BKP_IP:$BKP_2_PATH >> $BKP_2_LOG 100<<<$BKP_PASS
/usr/sbin/ssmtp sistemas@3dbconsult.com < $BKP_2_LOG

# Rsync de ORIGEN a AYER (Origen > BCK-1)
echo -e "To: sistemas@3dbconsult.com\nFrom: notificaciones.sistemas@3dbconsult.com\nSubject: Backup - Ayer\n" > $BKP_1_LOG
$RSYNC 'sshpass -d 200 ssh -p 22' $SOURCE_USER@$SOURCE_IP:$SOURCE_PATH $BKP_1_PATH >> $BKP_1_LOG 200<<<$SOURCE_PASS
/usr/sbin/ssmtp sistemas@3dbconsult.com < $BKP_1_LOG
