#!/bin/bash

# Check and install git if not installed
if ! command -v git &> /dev/null; then
    sudo apt update
    sudo apt install -y git
fi

echo "Clone https://github.com/waveshare/LCD-show.git.."

git clone https://github.com/waveshare/LCD-show.git
cd LCD-show
git checkout e91282e

echo "Copy waveshare35a overlay to /boot/overlays.."
sudo cp waveshare35a-overlay.dtb /boot/overlays/waveshare35a.dtbo

cd ..
rm -rf LCD-show

echo "Try to disable vc4-kms-v3d device tree overlay.."
sed -i 's/dtoverlay=vc4-kms-v3d/# dtoverlay=vc4-kms-v3d/' /boot/config.txt

echo "Add dtoverlay=waveshare35a to /boot/config.txt.."
if ! grep -qF "dtoverlay=waveshare35a" "/boot/config.txt"; then
  echo -e "\n[all]\ndtoverlay=waveshare35a" >> /boot/config.txt
fi

echo "Copy XOrg config.."
sudo cp 99-fbdev.conf /etc/X11/xorg.conf.d/
sudo cp 99-calibration.conf /etc/X11/xorg.conf.d/
sudo cp 10-evdev.conf /etc/X11/xorg.conf.d/

echo "Update boot/cmdline.txt.."
# Check if the file already contains the string
if grep -qF "fbcon=map:10 fbcon=font:VGA8x8" "/boot/cmdline.txt"; then
  echo "fbcon=map:10 fbcon=font:VGA8x8 already exists in /boot/cmdline.txt"
else
  # Append the string to the last line of the file
  echo " fbcon=map:10 fbcon=font:VGA8x8" >> "/boot/cmdline.txt"
  echo "fbcon=map:10 fbcon=font:VGA8x8 added to /boot/cmdline.txt"
fi

sudo apt-get install xserver-xorg-input-evdev


# Prompt the user to reboot
read -p "Do you want to reboot now? (yes/no): " choice

if [[ "$choice" =~ ^[Yy][Ee][Ss]$ ]]; then
  sudo reboot
else
  echo "Reboot canceled."
fi