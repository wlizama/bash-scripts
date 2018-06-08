#!/bin/bash


### Uso de if [[ condition ]]; then

echo "Ecribir nombre de archivo a buscar"

read ARCHIVO

if [ -f $ARCHIVO ]; then
        cat $ARCHIVO
else
        echo "el archivo $ARCHIVO no existe"
fi


### Uso de case ... in

echo "Ecribir nombre de archivo a buscar"

read SCRIPT

case $SCRIPT in
    "JULANO" )
        echo "Escribiste: JULANO"
        ;;
    "MENGANO")
        echo "Escribiste: MENGANO"
        ;;
    1)
        echo "El el número 1"
        ;;
    *)
        echo "Escribiste otra cosa: $SCRIPT"
esac

