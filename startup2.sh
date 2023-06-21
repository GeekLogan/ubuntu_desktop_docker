date
whoami
hostname

VNC_IP=$(hostname -i)

#mkdir -p "$HOME/.vnc"
#PASSWD_PATH="$HOME/.vnc/passwd"
#echo "$VNC_PW" | vncpasswd -f >> "$PASSWD_PATH"
#chmod 600  "$PASSWD_PATH"

#vncserver "$DISPLAY" -depth "$VNC_COL_DEPTH" -geometry "$VNC_RESOLUTION" -SecurityTypes=None &> "$START_DIR"/vnc_startup.log
/usr/bin/vncserver "$DISPLAY" -depth "$VNC_COL_DEPTH" -geometry "$VNC_RESOLUTION" -SecurityTypes=None -noxstartup
echo -e "\nConnect to $VNC_IP:$VNC_PORT"

set -e

# Disable screensaver and power management
xset s noblank
xset s 0 0
xset s off

# Launch terminal
/bin/startlxde
