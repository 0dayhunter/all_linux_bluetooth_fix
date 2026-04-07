# all_linux_bluetooth_fix
# ⚡ Bluetooth Auto Fix Script (Kali / Linux)

This script fully automates fixing Bluetooth issues on Linux systems (especially Kali Linux and Lenovo Ideapad devices).

It handles:

* 🔧 rfkill soft/hard blocks
* 💻 Lenovo `ideapad_laptop` module conflicts
* 📦 Bluetooth package installation
* 📡 Broadcom firmware setup
* 🔁 Bluetooth service reset
* 🔍 Automatic device scanning

---

## 🚀 Features

* One-command Bluetooth repair
* Works on fresh Kali installs
* Fixes “Bluetooth not scanning” issue
* Automatically installs required dependencies
* Handles firmware using the `broadcom-bt-firmware` repository
* Starts scanning for nearby devices after setup

---

## 📂 Requirements

* Linux system (Kali, Ubuntu-based recommended)
* `sudo` privileges
* Internet connection

---

## ⚡ How to Use

```bash
nano bt_fix.sh
# paste the script
chmod +x bt_fix.sh
./bt_fix.sh
```

---

## 📡 After Running

1. Open Bluetooth on your phone
2. Go to **“Pair new device”**
3. Keep the screen ON

Then on your system:

```bash
bluetoothctl
scan on
```

---

## 🔗 Pairing a Device

```bash
bluetoothctl
pair <MAC_ADDRESS>
connect <MAC_ADDRESS>
trust <MAC_ADDRESS>
```

---

## 🧠 Troubleshooting

### Bluetooth still not showing devices?

* Ensure your device is in pairing mode
* Try restarting Bluetooth:

  ```bash
  sudo systemctl restart bluetooth
  ```

### Adapter blocked again?

```bash
rfkill unblock all
```

---

## ⚠️ Notes

* Some devices only appear when actively pairing
* BLE devices may not show names immediately
* Script is optimized for Broadcom-based adapters

---

## 🛠️ What This Script Fixes

* `Soft blocked: yes` issues
* `No nearby Bluetooth devices found`
* Firmware missing errors
* Adapter stuck in scanning or idle state
* Lenovo-specific Bluetooth blocking bug

---

## 📜 License

Free to use and modify.

---

## 🙌 Credits

* Broadcom firmware from:
  https://github.com/winterheart/broadcom-bt-firmware

---

## ⚡ Quick Tip

If scanning works but no names appear:
👉 Keep your phone on the Bluetooth pairing screen

---

**Done. Your Bluetooth should now work flawlessly 🚀**
