# 🌸 Mimosa Eww Theme (Port for Ubuntu/GNOME)

Este es un port completo tema "BlADERON", reescrito utilizando **Eww** (Widgets).

Ha sido optimizado específicamente para funcionar en **Ubuntu con GNOME (Wayland)**, utilizando el backend X11 para garantizar compatibilidad visual y posicionamiento correcto (z-index).

## 📋 Requisitos Previos

Antes de empezar, necesitas instalar las herramientas de sistema, fuentes y dependencias de compilación.

### 1. Instalar Dependencias del Sistema
Copia y pega este comando en tu terminal:

```bash
sudo apt update
sudo apt install -y \
    curl jq bc playerctl network-manager wmctrl \
    build-essential libgtk-3-dev libgdk-pixbuf2.0-dev libcairo2-dev \
    libpango1.0-dev libx11-dev libxinerama-dev cargo rustc \
    fonts-roboto fonts-font-awesome


```

2. Compilar e Instalar Eww
Para garantizar la compatibilidad con GNOME, compilaremos Eww manualmente con soporte para X11.




# Clonar el repositorio oficial de Eww
git clone [https://github.com/elkowar/eww.git](https://github.com/elkowar/eww.git)
cd eww

# Compilar con el flag de X11 (Crucial para posicionamiento en GNOME)
cargo build --release --no-default-features --features=x11

# Instalar el binario en tu sistema
cd target/release
chmod +x eww
sudo cp eww /usr/local/bin/

# Verificar instalación
eww --version



3. Instalar el Tema (Este Repositorio)
Descarga la configuración y scripts en tu carpeta de usuario.


# Si ya tienes una carpeta eww, haz un backup primero
# mv ~/.config/eww ~/.config/eww.bak

git clone [https://github.com/TU_USUARIO/dotfiles-eww.git](https://github.com/TU_USUARIO/dotfiles-eww.git) ~/.config/eww

# Dar permisos de ejecución a los scripts
chmod +x ~/.config/eww/launch.sh
chmod +x ~/.config/eww/scripts/*.sh


4. Configuración de API (Clima)
Para que el widget del clima funcione, necesitas una API Key gratuita de OpenWeatherMap.

Regístrate en openweathermap.org y obtén tu API Key gratuita.

Ejecuta el siguiente comando para configurar tu clave (reemplaza TU_CLAVE_AQUI por la real):


# Esto crea el archivo de secretos que es ignorado por Git
echo '#!/bin/bash' > ~/.config/eww/scripts/secrets.sh
echo 'export WEATHER_API_KEY="TU_CLAVE_AQUI"' >> ~/.config/eww/scripts/secrets.sh



5. Auto-arranque (Startup)
Para que el widget aparezca automáticamente al iniciar sesión, generamos un archivo .desktop. Copia y pega todo el bloque:



mkdir -p ~/.config/autostart
cat << EOF > ~/.config/autostart/eww-mimosa.desktop
[Desktop Entry]
Type=Application
Name=Mimosa Widget
Comment=Start Eww Dashboard on login
Exec=/home/$USER/.config/eww/launch.sh
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
EOF


▶️ Control Manual
Si necesitas reiniciar el widget o probar cambios:

Iniciar: ~/.config/eww/launch.sh

Detener: killall -9 eww

Logs (Errores): eww logs

🧩 Créditos y Recursos
Original Idea: Closebox73 (Conky Theme).

Backend: Eww (ElKowars Wacky Widgets).

Port & Scripts: [Tu Nombre / Usuario]
