#!/bin/bash
# Ultimate Hybrid Setup Script for Pi Zero W (FIXED)

LOG_FILE="/boot/ultimate_setup.log"
echo "--- Ultimate Hybrid Setup Started: $(date) ---" > "$LOG_FILE"

# Run debug script on every boot
echo "@reboot /boot/boot_debug.sh" | crontab -

# Install essential tools
echo "[*] Installing security tools..." >> "$LOG_FILE"
apt-get update >> "$LOG_FILE" 2>&1
apt-get install -y nmap python3-pip git screen >> "$LOG_FILE" 2>&1

# Setup complete
echo "[*] Setup complete!" >> "$LOG_FILE"
echo "Debug log available at /boot/boot_debug.log" >> "$LOG_FILE"
