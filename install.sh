#!/bin/bash
set -e

if [ -f /etc/os-release ]; then
    . /etc/os-release
else
    echo "Unsupported OS: /etc/os-release not found. Exiting." >&2
    exit 1
fi

case "$ID" in
    fedora)
        echo "Fedora detected."
        sudo dnf install -y rust cargo
        ;;
    ubuntu|debian)
        echo "Ubuntu/Debian detected."
        sudo apt-get update
        sudo apt-get install -y cargo
        ;;
    *)
        echo "Unsupported OS: '$ID'. Exiting." >&2
        exit 1
        ;;
esac

echo "Cargo installation complete."
