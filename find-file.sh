#!/bin/bash

pwd = $(pwd)

echo "Ecribir nombre de archivo a buscar"

read ARCHIVO

if [ -f $ARCHIVO ]; then
    cat $ARCHIVO
else
    echo "el archivo $ARCHIVO no existe"
fi