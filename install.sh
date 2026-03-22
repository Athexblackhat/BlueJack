#!/bin/bash
# BlueJack Linux Installation Script

echo "=========================================="
echo "BlueJack - Bluetooth HID Attack Tool"
echo "Linux Installation"
echo "=========================================="

# Check if running on Linux
if [[ "$OSTYPE" != "linux-gnu"* ]]; then
    echo "Error: BlueJack is only supported on Linux"
    echo "For Windows, please use WSL2 or a virtual machine"
    exit 1
fi

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    echo "Please run with sudo"
    exit 1
fi

# Install system dependencies
echo "Installing system dependencies..."
apt-get update
apt-get install -y \
    python3 \
    python3-pip \
    python3-dev \
    python3-dbus \
    python3-gi \
    bluez \
    bluez-tools \
    libbluetooth-dev \
    libglib2.0-dev \
    libdbus-1-dev

# Install Python packages
echo "Installing Python packages..."

# Install pybluez from GitHub (fixed version)
pip3 install git+https://github.com/pybluez/pybluez.git

# Install other dependencies
pip3 install pydbus
pip3 install dbus-python
pip3 install PyGObject

# Create directories
mkdir -p payloads
mkdir -p logs

# Set permissions
chmod +x BlueJack.py

echo "=========================================="
echo "Installation Complete!"
echo "=========================================="
echo "Run with: sudo python3 BlueJack.py"
echo ""
echo "Note: You need a Bluetooth adapter"
echo "Check adapter: hciconfig"
echo "=========================================="