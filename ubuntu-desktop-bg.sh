#!/bin/bash

# obtener nombre de archivo setteado como fondo de escritorio actual
#gsettings get org.gnome.desktop.background picture-uri

# configurar fondo de escritorio
#gsettings set org.gnome.desktop.background picture-uri 'file:///home/wilder/Imágenes/wallpapers/256539.jpg'


# simple url decode
urldecode() { : "${*//+/ }"; echo -e "${_//%/\\x}"; }

# solución ejecucion desde crontab
# * * * * * ~/WildPersonal/develop/bash-scripts/ubuntu-desktop-bg.sh
# https://askubuntu.com/questions/140305/cron-not-able-to-succesfully-change-background#answer-198508
user=$(whoami)

fl=$(find /proc -maxdepth 2 -user $user -name environ -print -quit)
while [ -z $(grep -z DBUS_SESSION_BUS_ADDRESS "$fl" | cut -d= -f2- | tr -d '\000' ) ]
do
  fl=$(find /proc -maxdepth 2 -user $user -name environ -newer "$fl" -print -quit)
done

export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS "$fl" | cut -d= -f2-)



# Folder contenedor de imágenes
PATH_WALLPAPERS=~/Imágenes/wallpapers

img_names=($(ls "$PATH_WALLPAPERS"/))

current_bg=`gsettings get org.gnome.desktop.background picture-uri`
current_bg_dec=$(urldecode "$current_bg")

idx_next=0
for img_idx in "${!img_names[@]}"; do
    full_path=$PATH_WALLPAPERS/${img_names[img_idx]}
    # verifica la imagen actual para aumentar indice de imagen siguiente
    if [[ $current_bg_dec == *$full_path* ]]; then
        idx_next=$((img_idx + 1))
    fi
done

# verifica si el indice array es OK
if (( ${#img_names[idx_next]} < 1 )); then
    idx_next=0
fi

path_img_next="${PATH_WALLPAPERS}/${img_names[idx_next]}"

# verifica si archivo existe
if [[ ! -f "$path_img_next" ]]; then
    idx_next=0
fi

# set background
DISPLAY=:0 GSETTINGS_BACKEND=dconf gsettings set org.gnome.desktop.background picture-uri file://$path_img_next

printf "Nuevo: $path_img_next \n  Ant: $current_bg_dec\n\n"

exit 0