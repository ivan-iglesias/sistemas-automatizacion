#!/bin/bash

# =======================================================================================
# DESCRIPCION
# Elimino ficheros asociados de maquinas virtuales en las rutas indicadas.
#
# EJEMPLO
# 00 20 * * *  /home/administrador/scripts/borrar_temporal_vm.sh
# =======================================================================================

PATHS=("/mnt/serv_datos/TEMPORAL/"
       "/mnt/serv_datos/2019/proyecto_1/temporal/"
       "/mnt/serv_datos/2020/proyecto_2/temporal/")

for path in "${PATHS[@]}"; do
    find "$path" -name '*.vmdk' -exec rm {} \;
    find "$path" -name '*.vmem' -exec rm {} \;
    find "$path" -name '*.nvram' -exec rm {} \;
    find "$path" -name '*.vmsd' -exec rm {} \;
    find "$path" -name '*.vmx' -exec rm {} \;
    find "$path" -name '*.vmxf' -exec rm {} \;
    find "$path" -name '*.appicon' -exec rm {} \;
    find "$path" -name '*.lck' -exec rm {} \;
    find "$path" -name '*.vdi' -exec rm {} \;
    find "$path" -name '*.vdi' -exec rm {} \;
    find "$path" -name '*.vbox' -exec rm {} \;
    find "$path" -name '*.vbox-prev' -exec rm {} \;
done
