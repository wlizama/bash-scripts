#!/bin/bash

# obtener nombre de archivo setteado como fondo de escritorio actual
#gsettings get org.gnome.desktop.background picture-uri

# configurar fondo de escritorio
#gsettings set org.gnome.desktop.background picture-uri 'file:///home/wilder/Imágenes/wallpapers/256539.jpg'


# simple url decode
urldecode() { : "${*//+/ }"; echo -e "${_//%/\\x}"; }

# Folder contenedor de imágenes
PATH_WALLPAPERS=/home/wilder/Imágenes/wallpapers

img_names=($(ls "$PATH_WALLPAPERS"/))

current_bg=`gsettings get org.gnome.desktop.background picture-uri`
current_bg_dec=$(urldecode "$current_bg")

idx_next=0
for img_idx in "${!img_names[@]}"; do
    full_path=$PATH_WALLPAPERS/${img_names[img_idx]}
    if [[ $current_bg_dec == *$full_path* ]]; then
        idx_next=$((img_idx + 1))
    fi
done

# verifica si el indice array es OK
if (( ${#img_names[idx_next]} < 1 )); then
    idx_next=0
fi

# verifica si archivo existe
if [[ ! -f "$full_path" ]]; then
    idx_next=0
fi

# set background
gsettings set org.gnome.desktop.background picture-uri "file://${PATH_WALLPAPERS}/${img_names[idx_next]}"

echo ${img_names[idx_next]}
