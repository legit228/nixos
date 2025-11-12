#!/usr/bin/env bash

# Disable USB device 1-3 from waking up the system
echo "disabled" | sudo tee /sys/bus/usb/devices/1-3/power/wakeup > /dev/null

# Check if 1-3.1 exists and disable it if it does
if [ -f "/sys/bus/usb/devices/1-3.1/power/wakeup" ]; then
    echo "disabled" | sudo tee /sys/bus/usb/devices/1-3.1/power/wakeup > /dev/null
fi

# Check if 1-3.4 exists and disable it if it does
if [ -f "/sys/bus/usb/devices/1-3.4/power/wakeup" ]; then
    echo "disabled" | sudo tee /sys/bus/usb/devices/1-3.4/power/wakeup > /dev/null
fi
