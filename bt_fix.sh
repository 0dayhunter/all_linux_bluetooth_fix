#!/usr/bin/env bash
set -e

echo "⚡ Starting FULL Bluetooth Fix & Setup..."

# -------------------------------
# 1. Install dependencies
# -------------------------------
echo "📦 Installing Bluetooth packages..."
sudo apt update -y
sudo apt install -y bluetooth bluez bluez-tools rfkill git

# -------------------------------
# 2. Fix Lenovo ideapad block
# -------------------------------
echo "🔧 Fixing ideapad Bluetooth block..."
sudo modprobe -r ideapad_laptop 2>/dev/null || true

# Optional permanent fix
if [ ! -f /etc/modprobe.d/blacklist-ideapad.conf ]; then
    echo "blacklist ideapad_laptop" | sudo tee /etc/modprobe.d/blacklist-ideapad.conf
fi

# -------------------------------
# 3. Unblock Bluetooth
# -------------------------------
echo "📡 Unblocking Bluetooth..."
rfkill unblock all

# -------------------------------
# 4. Restart Bluetooth service
# -------------------------------
echo "🔁 Restarting Bluetooth service..."
sudo systemctl daemon-reexec
sudo systemctl enable bluetooth
sudo systemctl restart bluetooth

# -------------------------------
# 5. Clone firmware repo
# -------------------------------
echo "⬇️ Setting up firmware..."
mkdir -p "$HOME/lib"
cd "$HOME/lib"

if [ -d "broadcom-bt-firmware" ]; then
    echo "🔄 Updating firmware repo..."
    cd broadcom-bt-firmware
    git pull
else
    git clone https://github.com/winterheart/broadcom-bt-firmware.git
    cd broadcom-bt-firmware
fi

# Copy firmware (ignore errors if already present)
sudo mkdir -p /lib/firmware/brcm
sudo cp -r brcm/* /lib/firmware/brcm/ 2>/dev/null || true

# -------------------------------
# 6. Reset Bluetooth adapter
# -------------------------------
echo "🔄 Resetting adapter..."
sudo systemctl stop bluetooth || true
sudo pkill bluetoothd || true
sudo modprobe -r btusb || true
sudo modprobe btusb

sudo systemctl start bluetooth

# -------------------------------
# 7. Bring interface up
# -------------------------------
echo "📶 Bringing interface up..."
hciconfig hci0 up || true
hciconfig hci0 reset || true

# -------------------------------
# 8. Final unblock (again)
# -------------------------------
rfkill unblock all

# -------------------------------
# 9. Start scan automatically
# -------------------------------
echo "🔍 Starting Bluetooth scan..."
sleep 2

bluetoothctl <<EOF
power on
agent on
default-agent
scan on
EOF

echo ""
echo "✅ DONE!"
echo "👉 Keep your phone in 'Pair new device' screen"
echo "👉 Use: bluetoothctl to pair devices"
echo ""
