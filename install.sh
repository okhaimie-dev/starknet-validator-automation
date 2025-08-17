#!/bin/bash
set -e

echo "Detecting OS..."

if [ -f /etc/os-release ]; then
  . /etc/os-release
  OS_ID=$ID
else
  echo "Cannot detect OS. Exiting." >&2
  exit 1
fi

install_dependencies_fedora() {
  echo "Fedora detected."
  sudo dnf install -y ansible
}

install_dependencies_ubuntu() {
  echo "Ubuntu/Debian detected."
  sudo apt-get update
  sudo apt-get install -y ansible
}

case "$OS_ID" in
  fedora)
    install_dependencies_fedora
    ;;
  ubuntu|debian)
    install_dependencies_ubuntu
    ;;
  *)
    echo "Unsupported OS: $OS_ID. Exiting."
    exit 1
    ;;
esac

# Verify installations
command -v ansible >/dev/null 2>&1 || { echo "Ansible installation failed" >&2; exit 1; }

echo "Installation complete."

ansible-playbook -c local validator-node.yml -vv
