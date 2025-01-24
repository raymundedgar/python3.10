#!/bin/bash

# Ensure the script is run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root. Use sudo." 
   exit 1
fi

echo "Updating system..."
apt update && apt upgrade -y

echo "Installing required dependencies..."
apt install -y software-properties-common build-essential curl

echo "Adding Deadsnakes PPA..."
add-apt-repository -y ppa:deadsnakes/ppa
apt update

echo "Installing Python 3.10..."
apt install -y python3.10 python3.10-venv python3.10-distutils

echo "Setting Python 3.10 as the default Python3 version..."
update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1
update-alternatives --set python3 /usr/bin/python3.10

echo "Upgrading pip for Python 3.10..."
curl -sS https://bootstrap.pypa.io/get-pip.py | python3.10

# Verify installation
echo "Verifying Python installation..."
python3 --version
pip --version

echo "Python 3.10 installation and configuration complete!"
