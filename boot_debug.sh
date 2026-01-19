#!/bin/bash
# Boot Debug Script - Logs everything to /boot/boot_debug.log

DEBUG_LOG="/boot/boot_debug.log"

echo "===== BOOT DEBUG LOG =====" > $DEBUG_LOG
echo "Boot Time: $(date)" >> $DEBUG_LOG
echo "" >> $DEBUG_LOG

echo "[*] System Info:" >> $DEBUG_LOG
uname -a >> $DEBUG_LOG 2>&1
echo "" >> $DEBUG_LOG

echo "[*] Network Interfaces:" >> $DEBUG_LOG
ip addr >> $DEBUG_LOG 2>&1
echo "" >> $DEBUG_LOG

echo "[*] WiFi Status:" >> $DEBUG_LOG
iwconfig 2>&1 >> $DEBUG_LOG
echo "" >> $DEBUG_LOG

echo "[*] WiFi Scan:" >> $DEBUG_LOG
iwlist wlan0 scan 2>&1 | grep -E "ESSID|Quality" >> $DEBUG_LOG
echo "" >> $DEBUG_LOG

echo "[*] wpa_supplicant status:" >> $DEBUG_LOG
wpa_cli -i wlan0 status >> $DEBUG_LOG 2>&1
echo "" >> $DEBUG_LOG

echo "[*] DHCP Status:" >> $DEBUG_LOG
ps aux | grep dhcp >> $DEBUG_LOG 2>&1
echo "" >> $DEBUG_LOG

echo "[*] Routing Table:" >> $DEBUG_LOG
route -n >> $DEBUG_LOG 2>&1
echo "" >> $DEBUG_LOG

echo "[*] DNS Configuration:" >> $DEBUG_LOG
cat /etc/resolv.conf >> $DEBUG_LOG 2>&1
echo "" >> $DEBUG_LOG

echo "[*] System Journal (last 50 lines):" >> $DEBUG_LOG
journalctl -n 50 >> $DEBUG_LOG 2>&1
echo "" >> $DEBUG_LOG

echo "===== DEBUG LOG COMPLETE =====" >> $DEBUG_LOG
chmod 644 $DEBUG_LOG
