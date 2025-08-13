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
        sudo dnf install -y rust cargo ansible zstd
        ;;
    ubuntu|debian)
        echo "Ubuntu/Debian detected."
        sudo apt-get update
        sudo apt-get install -y cargo ansible
        ;;
    *)
        echo "Unsupported OS: '$ID'. Please report in issues for OS installation support." >&2
        exit 1
        ;;
esac

# Verify installations
command -v cargo >/dev/null 2>&1 || { echo "Cargo installation failed" >&2; exit 1; }
command -v ansible >/dev/null 2>&1 || { echo "Ansible installation failed" >&2; exit 1; }

echo "Installation complete."


ansible-playbook -c local test.yml -vv

