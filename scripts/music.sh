#!/bin/bash

# Obtener estado (Playing, Paused, o vacío)
status=$(playerctl status 2>/dev/null)

if [ -z "$status" ]; then
    # Si no hay nada abierto
    echo '{"title": "Sin reproducción", "artist": "...", "icon": "", "lbl": "Inactivo"}'
else
    # Limpiar comillas para no romper el JSON
    title=$(playerctl metadata title 2>/dev/null | sed 's/"/\\"/g')
    artist=$(playerctl metadata artist 2>/dev/null | sed 's/"/\\"/g')
    
    if [ "$status" == "Playing" ]; then
        icon="" # Icono de Pausa
        lbl="Reproduciendo"
    else
        icon="" # Icono de Play
        lbl="Pausado"
    fi
    
    # Si no hay artista, poner desconocido
    if [ -z "$artist" ]; then artist="Desconocido"; fi
    
    echo "{\"title\": \"$title\", \"artist\": \"$artist\", \"icon\": \"$icon\", \"lbl\": \"$lbl\"}"
fi
