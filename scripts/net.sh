#!/bin/bash

# Detectar interfaz de red por defecto
INTERFACE=$(ip route | grep default | head -n1 | awk '{print $5}')
prev_rx=0; prev_tx=0; max_rx=1; max_tx=1

get_bytes() {
    if [ -z "$INTERFACE" ] || [ ! -d "/sys/class/net/$INTERFACE" ]; then echo "0 0"; return; fi
    rx=$(cat /sys/class/net/$INTERFACE/statistics/rx_bytes 2>/dev/null || echo 0)
    tx=$(cat /sys/class/net/$INTERFACE/statistics/tx_bytes 2>/dev/null || echo 0)
    echo "$rx $tx"
}

format_speed() {
    local speed=$1
    if [ $speed -gt 1073741824 ]; then echo "$(bc <<< "scale=2; $speed / 1073741824")GiB/s"
    elif [ $speed -gt 1048576 ]; then echo "$(bc <<< "scale=2; $speed / 1048576")MiB/s"
    elif [ $speed -gt 1024 ]; then echo "$(bc <<< "scale=2; $speed / 1024")KiB/s"
    else echo "${speed}B/s"; fi
}

read prev_rx prev_tx <<< $(get_bytes)

while true; do
    sleep 1
    read curr_rx curr_tx <<< $(get_bytes)
    
    speed_rx=$((curr_rx - prev_rx))
    speed_tx=$((curr_tx - prev_tx))
    
    # Actualizar máximos
    [ $speed_rx -gt $max_rx ] && max_rx=$speed_rx
    [ $speed_tx -gt $max_tx ] && max_tx=$speed_tx
    
    # --- CAMBIO IMPORTANTE: DETECCIÓN DE SSID ---
    # Pregunta por el nombre de la conexión activa (Connection ID)
    ssid=$(nmcli -t -f NAME connection show --active | head -n1)
    
    # Si sigue vacío, poner un texto por defecto
    if [ -z "$ssid" ]; then ssid="Desconectado"; fi
    
    # Limitar el nombre a 15 caracteres para que no rompa el diseño
    ssid=$(echo "$ssid" | cut -c 1-15)
    
    # Generar JSON
    echo "{\"ssid\":\"$ssid\",\"down\":{\"txt\":\"$(format_speed $speed_rx)\",\"val\":$speed_rx.0,\"max_txt\":\"$(format_speed $max_rx)\",\"max_val\":$max_rx.0},\"up\":{\"txt\":\"$(format_speed $speed_tx)\",\"val\":$speed_tx.0,\"max_txt\":\"$(format_speed $max_tx)\",\"max_val\":$max_tx.0}}"
    
    prev_rx=$curr_rx; prev_tx=$curr_tx
done
