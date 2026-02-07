# dietpi-zerow-ultimate-hybrid

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![GitHub stars](https://img.shields.io/github/stars/Panda1847/dietpi-zerow-ultimate-hybrid)](https://github.com/Panda1847/dietpi-zerow-ultimate-hybrid/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/Panda1847/dietpi-zerow-ultimate-hybrid)](https://github.com/Panda1847/dietpi-zerow-ultimate-hybrid/network)
[![GitHub issues](https://img.shields.io/github/issues/Panda1847/dietpi-zerow-ultimate-hybrid)](https://github.com/Panda1847/dietpi-zerow-ultimate-hybrid/issues)
[![Language](https://img.shields.io/badge/language-Shell-blue.svg)](https://github.com/Panda1847/dietpi-zerow-ultimate-hybrid)


**A Custom Penetration Testing & Security Research Platform for Raspberry Pi Zero W**

## 📋 Overview

This is a lightweight, powerful hybrid OS combining:
- **DietPi** - Ultra-lightweight Debian-based OS
- **Kali Linux Tools** - Essential penetration testing toolkit
- **P4wnP1-inspired Features** - USB attack capabilities
- **Automated Setup** - Zero-touch deployment

Perfect for:
- ✅ Penetration Testing
- ✅ Security Research
- ✅ Physical Red Team Operations
- ✅ Network Analysis
- ✅ Learning Ethical Hacking

---

## 🎯 Features

### Pre-Installed Security Tools
- **nmap** - Network scanning
- **aircrack-ng** - WiFi security auditing
- **bettercap** - Network attack framework
- **Python3 + pip** - Custom exploit development
- **screen** - Terminal multiplexing
- **git** - Version control

### Network Configuration
- **Static IP**: `192.168.1.199` (pre-configured)
- **Dual WiFi Networks**: Automatic failover
- **SSH Enabled**: Remote access out-of-box
- **Debug Logging**: `/boot/boot_debug.log`

### Hardware Optimization
- Optimized for Pi Zero W (512MB RAM)
- Low power consumption
- Headless operation
- UART console enabled

---

## 🔧 Quick Start

### 1️⃣ Flash to SD Card

**Linux/macOS:**
```bash
# Extract image
xz -d DietPi_ZeroW_Ultimate_Hybrid.img.xz

# Flash to SD card (replace /dev/sdX with your SD card)
sudo dd if=DietPi_ZeroW_Ultimate_Hybrid.img of=/dev/sdX bs=4M status=progress conv=fsync
sudo sync
```

**Windows:**
- Use [Balena Etcher](https://www.balena.io/etcher/)
- Select extracted .img file
- Flash to SD card

### 2️⃣ Configure WiFi (Optional)

Edit `dietpi-wifi.txt` on boot partition:
```bash
aWIFI_SSID[0]='YourNetworkName'
aWIFI_KEY[0]='YourPassword'
```

### 3️⃣ Boot & Connect

1. Insert SD card into Pi Zero W
2. Power via PWR port (5V/1A minimum)
3. Wait 3-5 minutes for first boot
4. SSH: `ssh root@192.168.1.199`
5. Default password: `dietpi`

---

## 📡 Network Configuration

### Default Settings
- **IP Address**: 192.168.1.199
- **Gateway**: 192.168.1.254
- **DNS**: 8.8.8.8, 8.8.4.4
- **WiFi Networks**: 
  - Primary: Your_SSID_Here
  - Backup: Your_SSID_Here_2GEXT

### Change Static IP
Edit `/etc/network/interfaces.d/wlan0`:
```bash
auto wlan0
iface wlan0 inet static
    address 192.168.1.XXX  # Your desired IP
    netmask 255.255.255.0
    gateway 192.168.1.254
```

---

## 🐛 Troubleshooting

### Can't Connect via SSH

1. **Check Pi is powered properly** (needs 5V/1A minimum)
2. **Verify WiFi credentials** in `dietpi-wifi.txt`
3. **Check debug log**:
   ```bash
   # Re-mount SD card on your computer
   cat /boot/boot_debug.log
   ```
4. **Scan network**:
   ```bash
   sudo nmap -sn 192.168.1.0/24
   ```

### Pi Won't Boot

- **Green LED solid**: Boot failure (check SD card quality)
- **Green LED blinking**: Normal boot process
- **No LED**: No power or hardware issue

**Solution**: Use quality SD card (SanDisk/Samsung Class 10)

### WiFi Not Connecting

1. Check SSID/password in `dietpi-wifi.txt`
2. Verify 2.4GHz network (Pi Zero W doesn't support 5GHz)
3. Check router allows new devices

---

## 📁 File Structure

```
/boot/
├── dietpi-wifi.txt              # WiFi configuration
├── dietpi.txt                   # DietPi settings
├── config.txt                   # Raspberry Pi config
├── cmdline.txt                  # Boot parameters
├── boot_debug.sh                # Debug script
├── Automation_Custom_Script.sh  # First-run setup
└── ssh                          # Enables SSH

/etc/
├── network/interfaces.d/wlan0   # Static IP config
└── wpa_supplicant/              # WiFi management
```

---

## 🛠️ Advanced Usage

### Install Additional Tools

```bash
# Update package list
apt update

# Install tools
apt install -y metasploit-framework sqlmap hydra

# DietPi optimized install
dietpi-software install <software_id>
```

### USB Gadget Mode (Future)

Currently disabled to ensure stable boot.
To enable USB ethernet:
```bash
echo dtoverlay=dwc2 >> /boot/config.txt
sed -i 's/rootwait/rootwait modules-load=dwc2,g_ether/' /boot/cmdline.txt
```

### Custom Scripts

Place scripts in `/root/` or `/boot/` for persistence.

---

## ⚠️ Legal Disclaimer

**FOR EDUCATIONAL AND AUTHORIZED TESTING ONLY**

This tool is designed for:
- ✅ Authorized penetration testing
- ✅ Security research in controlled environments
- ✅ Learning ethical hacking techniques

**NEVER use on networks/systems without explicit written permission.**

Unauthorized access is illegal. Users are responsible for compliance with all applicable laws.

---

## 🤝 Contributing

Found a bug? Want to add features?

1. Fork the repository
2. Create feature branch: `git checkout -b feature-name`
3. Commit changes: `git commit -m 'Add feature'`
4. Push: `git push origin feature-name`
5. Submit Pull Request

---

## 📜 Credits

Built by: **Manus AI**

Based on:
- [DietPi](https://dietpi.com/) - Lightweight Raspberry Pi OS
- [Kali Linux](https://www.kali.org/) - Security tools
- [P4wnP1 A.L.O.A.](https://github.com/RoganDawes/P4wnP1_aloa) - Inspiration

---

## 📝 License

**MIT License** - Free to use, modify, distribute

See LICENSE file for details.

---

## 🔗 Resources

- **DietPi Docs**: https://dietpi.com/docs/
- **Kali Tools**: https://www.kali.org/tools/
- **Pi Zero W Specs**: https://www.raspberrypi.com/products/raspberry-pi-zero-w/

---

## ⭐ Star This Project!

If you find this useful, please star the repository and share with the community!

**Happy Hacking! 🎩**
