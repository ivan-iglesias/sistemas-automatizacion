# Automatizacion de Tareas

Scripts para automatizar tareas de sistemas.

- **backup_ficheros**

Copias de seguridad de ficheros. Cada hora de 8 a 18, eliminando los ficheros con más de un día de antiguedad.
```sh
00 08-18 * * * /home/administrador/scripts/backup_ficheros.sh
```

- **backup_servidor**

Crea copias de la carpeta raiz de trabajo en dos servidores. Los servidores tendra una copia completa del contenido de la carpeta raiz de ayer (BCK-1) y de anteayer (BCK-2).
```sh
00 21 * * 1,2,3,4,5 /home/administrador/scripts/backup_servidor.sh
```

- **borrar_exports**

Elimina los ficheros fuente del dia actual menos 14 dias. En el caso de que el dia actual sea viernes, antes de eliminarlo crea un comprimido con los ficheros fuente. Comprime y elimina la carpeta del dia actual menos 28 dias.
```sh
00 02 * * *  /home/administrador/scripts/borrar_exports.sh
```

- **borrar_temporal_vm**

Elimino ficheros asociados de maquinas virtuales en las rutas indicadas.
```sh
00 20 * * *  /home/administrador/scripts/borrar_temporal_vm.sh
```

- **borrar_temporal**

Borra los ficheros con mas de 5 dias que se encuentran en el directorio indicado.
```sh
00 01 * * *  /home/administrador/scripts/borrar_temporal.sh
```

- **crear_carpetas**

Automatizar la creación de carpetas.
```sh
10 00 * * * /home/administrador/scripts/crear_carpetas.sh
```

- **monitorizar**

Monitoriza que existan los ficheros indicados en el fichero pasado por argumento. En caso de que no exista alguno manda un email.
```sh
0 10 * * 1,2,3,4,5 /home/.../monitorizar.sh /home/.../monitorizar_rutas.txt
```
