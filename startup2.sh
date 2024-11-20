#!/bin/bash

# This script is chainloaded in the userspace permissions by startup.sh 

# Display environment variables
echo "It's $(date)"
echo "User:     $(whoami)"
echo "Hostname: $(hostname)"
echo "IP:       $(hostname -i)"

VNC_IP=$(hostname -i)
set -x

#mkdir -p "$HOME/.vnc"
#PASSWD_PATH="$HOME/.vnc/passwd"
#echo "$VNC_PW" | vncpasswd -f >> "$PASSWD_PATH"
#chmod 600  "$PASSWD_PATH"

# Launch VNC server as virtual monitor
vncserver "$DISPLAY" -depth "$VNC_COL_DEPTH" -geometry "$VNC_RESOLUTION" -SecurityTypes=None -noxstartup -localhost no --I-KNOW-THIS-IS-INSECURE
echo -e "Connect to $VNC_IP:$VNC_PORT"

# Disable screensaver and power management
xset s noblank
xset s 0 0
xset s off

# Launch desktop environment
/bin/startlxde
