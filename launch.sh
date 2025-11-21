#!/bin/bash

# --- DIAGNÓSTICO: Guardar todo lo que pase en un archivo ---
LOG_FILE="/tmp/eww_debug.log"
echo "Iniciando script de arranque: $(date)" > "$LOG_FILE"

# 1. Asegurar que el sistema encuentre el comando 'eww'
# (A veces al inicio no sabe buscar en tus carpetas personales)
export PATH="$PATH:/usr/local/bin:$HOME/.local/bin:$HOME/bin"

# 2. Esperar a que el entorno gráfico esté listo (Vital para Wayland/GNOME)
echo "Esperando 5 segundos para asegurar carga gráfica..." >> "$LOG_FILE"
sleep 2

# 3. Limpiar procesos viejos
echo "Matando instancias previas..." >> "$LOG_FILE"
killall -9 eww 2>> "$LOG_FILE"

# 4. Iniciar el demonio (Backend X11)
echo "Iniciando demonio..." >> "$LOG_FILE"
GDK_BACKEND=x11 eww daemon --no-daemonize >> "$LOG_FILE" 2>&1 &

# Esperar a que el demonio arranque
sleep 2

# 5. Abrir la ventana
echo "Abriendo ventana mimosa_full..." >> "$LOG_FILE"
eww open mimosa_full >> "$LOG_FILE" 2>&1

# 6. Ajustar posición (Fondo)
sleep 1
if command -v wmctrl &> /dev/null; then
    echo "Ajustando z-index con wmctrl..." >> "$LOG_FILE"
    wmctrl -r "mimosa_full" -b add,below >> "$LOG_FILE" 2>&1
else
    echo "Advertencia: wmctrl no encontrado" >> "$LOG_FILE"
fi

echo "Script finalizado exitosamente." >> "$LOG_FILE"
