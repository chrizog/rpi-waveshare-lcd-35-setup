# rpi-waveshare-lcd-35-setup

A Raspberry Pi installation script for a 3.5 inch TFT Waveshare touch screen.

This script will automatically configure the following steps without overwriting your existing configuration:

1. Configure device tree overlays for ILI9486 LCD controller and the ADS7846 touch controller.
2. Configure the XOrg FBdev framebuffer driver.
3. Install and configure the XOrg evdev driver.
4. Update the XOrg touchscreen calibration.

For usage just put the repository on your Raspberry Pi and execute the **installer-script.sh**.

```bash
git clone https://github.com/chrizog/rpi-waveshare-lcd-35-setup.git
cd rpi-waveshare-lcd-35-setup
./installer-script.sh
```

Detailed instructions on the setup of a Waveshare 3.5 inch touch screen can be found on the blog article as well:

[Setting Up a TFT Touchscreen on a Raspberry Pi with a fbtft Linux Driver for Seamless Interaction](https://chrizog.com/rpi-linux-fbtft-touchscreen-setup)