#!/bin/bash

# Importar secretos
source "$HOME/.config/eww/scripts/secrets.sh"

# Usar la variable importada
api_key="$WEATHER_API_KEY"
city_id="$CITY"

unit=metric
lang=es
url="https://api.openweathermap.org/data/2.5/weather?id=${city_id}&appid=${api_key}&cnt=5&units=${unit}&lang=${lang}"
weather_file=~/.cache/weather.json

# Crear archivo si no existe
if [ ! -f "$weather_file" ]; then echo "{}" > "$weather_file"; fi

get_icon() {
    case $1 in
        "01d") echo "" ;; "01n") echo "" ;;
        "02d"|"02n"|"03d"|"03n"|"04d"|"04n") echo "" ;;
        "09d"|"09n"|"10d"|"10n") echo "" ;;
        "11d"|"11n") echo "" ;; "13d"|"13n") echo "" ;;
        "50d"|"50n") echo "" ;; *) echo "" ;;
    esac
}

# Intentar descargar (con timeout de 3 segs para no congelar)
if [ $(find "$weather_file" -mmin +10 2>/dev/null) ] || [ ! -s "$weather_file" ]; then
    curl -s --connect-timeout 3 "${url}" -o "$weather_file"
fi

# VERIFICACIÓN DE SEGURIDAD
if [ -s "$weather_file" ] && jq -e .main "$weather_file" >/dev/null 2>&1; then
    # Si el archivo es válido, procesamos
    temp=$(jq '.main.temp' "$weather_file" | awk '{print int($1+0.5)}')
    desc=$(jq -r '.weather[0].description' "$weather_file" | sed 's/.*/\L&/; s/[a-z]*/\u&/g')
    icon_code=$(jq -r '.weather[0].icon' "$weather_file")
    icon=$(get_icon "$icon_code")
    city=$(jq -r '.name' "$weather_file")
    wind=$(jq '.wind.speed' "$weather_file")
    hum=$(jq '.main.humidity' "$weather_file")
    
    echo "{\"temp\":\"${temp}°C\", \"desc\":\"${desc}\", \"icon\":\"${icon}\", \"city\":\"${city}\", \"wind\":\"${wind} m/s\", \"hum\":\"${hum}%\"}"
else
    # Si falló la descarga o el archivo está corrupto, enviamos PLACEHOLDER
    echo "{\"temp\":\"--\", \"desc\":\"Offline\", \"icon\":\"\", \"city\":\"Sin Datos\", \"wind\":\"-\", \"hum\":\"-\"}"
fi
