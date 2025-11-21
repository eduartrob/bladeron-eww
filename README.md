# 🌸 Bladeron Theme (Port for Ubuntu/GNOME)

This is a complete port of the "Bladeron" theme, rewritten using **Eww** (Widgets).

It has been specifically optimized to work on **Ubuntu with GNOME (Wayland)**, using the X11 backend to ensure visual compatibility and correct positioning (z-index).

## 📋 Prerequisites

Before starting, you need to install system tools, fonts, and build dependencies.

### 1. Install System Dependencies
Copy and paste this command into your terminal:

```bash
sudo apt update
sudo apt install -y \
    curl jq bc playerctl network-manager wmctrl \
    build-essential libgtk-3-dev libgdk-pixbuf2.0-dev libcairo2-dev \
    libpango1.0-dev libx11-dev libxinerama-dev cargo rustc \
    fonts-roboto fonts-font-awesome
    
```

2. Compile and Install Eww
To ensure compatibility with GNOME, we will manually compile Eww with X11 support.



# Clone the official Eww repository
git clone [https://github.com/elkowar/eww.git](https://github.com/elkowar/eww.git)
cd eww

# Compile with the X11 flag (Crucial for positioning in GNOME)
cargo build --release --no-default-features --features=x11

# Install the binary to your system
cd target/release
chmod +x eww
sudo cp eww /usr/local/bin/

# Verify installation
eww --version


3. Install the Theme (This Repository)
Download the configuration and scripts to your user folder.

Bash

# If you already have an eww folder, make a backup first
# mv ~/.config/eww ~/.config/eww.bak

git clone [https://github.com/TU_USUARIO/dotfiles-eww.git](https://github.com/TU_USUARIO/dotfiles-eww.git) ~/.config/eww

# Give execution permissions to the scripts
chmod +x ~/.config/eww/launch.sh
chmod +x ~/.config/eww/scripts/*.sh


4. API Configuration (Weather)
For the weather widget to work, you need a free OpenWeatherMap API Key.

Register at openweathermap.org and get your free API Key.

Run the following command to configure your key (replace TU_CLAVE_AQUI with the real one):

Bash

# This creates the secrets file which is ignored by Git
echo '#!/bin/bash' > ~/.config/eww/scripts/secrets.sh
echo 'export WEATHER_API_KEY="TU_CLAVE_AQUI"' >> ~/.config/eww/scripts/secrets.sh


5. Autostart (Startup)
To make the widget appear automatically upon login, generate a .desktop file. Copy and paste the entire block:

Bash

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



▶️ Manual Control
If you need to restart the widget or test changes:

Start: ~/.config/eww/launch.sh

Stop: killall -9 eww

Logs (Errors): eww logs

🧩 Credits and Resources
Original Idea: Closebox73 (Conky Theme).

Backend: Eww (ElKowars Wacky Widgets).

Port & Scripts: [Your Name / User]
