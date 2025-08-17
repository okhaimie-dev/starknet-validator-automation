#!/bin/bash
set -e

echo "OS Detection..."

if [ -f /etc/os-release ]; then
  . /etc/os-release
  OS_ID=$ID
else
  echo "Cannot detect OS. Exiting." >&2
  exit 1
fi

install_dependencies_fedora() {
  echo "Installing dependencies for Fedora..."
  sudo dnf install -y ansible zstd curl
}

install_dependencies_ubuntu() {
  echo "Installing dependencies for Ubuntu/Debian..."
  sudo apt-get update
  sudo apt-get install -y ansible zstd curl
}

case "$OS_ID" in
  fedora)
    install_dependencies_fedora
    ;;
  ubuntu|debian)
    install_dependencies_ubuntu
    ;;
  *)
    echo "Unsupported OS: '$OS_ID'. Please report this in an issue to add support." >&2
    exit 1
    ;;
esac

# Verify installations
command -v ansible >/dev/null 2>&1 || { echo "Ansible installation failed" >&2; exit 1; }

echo "Dependencies installed successfully."

ansible-playbook -c local validator-node.yml -vv
