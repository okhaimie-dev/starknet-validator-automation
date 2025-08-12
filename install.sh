#!/bin/bash
set -e

if [ -f /etc/fedora-release ]; then
    echo "Fedora detected."
    sudo dnf install -y rust cargo
elif [ -f /etc/lsb-release ] || [ -f /etc/debian_version ]; then
    echo "Ubuntu/Debian detected."
    sudo apt-get update
    sudo apt-get install -y cargo
else
    echo "Unsupported OS."
    exit 1
fi

echo "Cargo installation complete."
