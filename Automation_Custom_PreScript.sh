#!/bin/bash
# DietPi Custom Pre-Script for RPi Zero W
# This script runs BEFORE networking is fully up on first boot.

LOG_FILE="/boot/pi_debug.log"
echo "--- Pi Zero W Custom Setup Started: $(date) ---" > "$LOG_FILE"

# 1. Force WiFi Configuration
echo "[*] Configuring WiFi for Your_SSID_Here..." >> "$LOG_FILE"
# Ensure the WiFi is enabled in dietpi.txt
sed -i 's/AUTO_SETUP_NET_WIFI_ENABLED=0/AUTO_SETUP_NET_WIFI_ENABLED=1/' /boot/dietpi.txt
sed -i 's/AUTO_SETUP_NET_ETHERNET_ENABLED=1/AUTO_SETUP_NET_ETHERNET_ENABLED=0/' /boot/dietpi.txt

# 2. Setup Self-Healing Service
echo "[*] Creating self-healing network service..." >> "$LOG_FILE"
cat << 'EOF' > /etc/systemd/system/wifi-monitor.sh
#!/bin/bash
while true; do
    if ! ping -c 1 8.8.8.8 > /dev/null 2>&1; then
        echo "$(date): Network down, attempting reconnect..." >> /boot/pi_debug.log
        ifconfig wlan0 down
        sleep 5
        ifconfig wlan0 up
        sleep 30
    fi
    # Write current IP to boot partition for easy discovery
    ip addr show wlan0 | grep "inet " | awk '{print $2}' | cut -d/ -f1 > /boot/my_ip.txt
    sleep 60
done
EOF
chmod +x /etc/systemd/system/wifi-monitor.sh

# 3. Create the service file
cat << 'EOF' > /etc/systemd/system/wifi-monitor.service
[Unit]
Description=WiFi Monitor and Self-Healer
After=network.target

[Service]
ExecStart=/etc/systemd/system/wifi-monitor.sh
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# 4. Enable SSH and Web Access
echo "[*] Ensuring SSH and Web services are ready..." >> "$LOG_FILE"
# DietPi handles this via dietpi.txt, but we'll double check
sed -i 's/AUTO_SETUP_SSH_SERVER_INDEX=-1/AUTO_SETUP_SSH_SERVER_INDEX=-2/' /boot/dietpi.txt # Switch to OpenSSH for better compatibility

# 5. IP Discovery via LED (Blink pattern)
echo "[*] Setting up LED blink for IP discovery..." >> "$LOG_FILE"
# This will blink the LED 5 times rapidly when it gets an IP
cat << 'EOF' > /etc/network/if-up.d/blink-ip
#!/bin/bash
if [ "$IFACE" = "wlan0" ]; then
    for i in {1..10}; do
        echo 1 > /sys/class/leds/led0/brightness
        sleep 0.1
        echo 0 > /sys/class/leds/led0/brightness
        sleep 0.1
    done
fi
EOF
chmod +x /etc/network/if-up.d/blink-ip

echo "[*] Custom setup script finished." >> "$LOG_FILE"
