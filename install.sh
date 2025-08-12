#!/bin/bash

set -e

echo "Detecting OS..."

if [ -f /etc/fedora-release ]; then
    echo "Fedora detected."
    sudo dnf install -y curl
elif [ -f /etc/lsb-release ] || [ -f /etc/debian_version ]; then
    echo "Ubuntu/Debian detected."
    sudo apt-get update
    sudo apt-get install -y curl
else
    echo "Unsupported OS. Exiting."
    exit 1
fi

echo "Installation completed successfully."
