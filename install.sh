#!/bin/bash
set -e

echo "Detecting OS..."

if [ -f /etc/os-release ]; then
  . /etc/os-release
  OS_ID=$ID
else
  echo "Cannot detect OS. Exiting."
  exit 1
fi

install_docker_fedora() {
  echo "Fedora detected."
  sudo dnf install -y rust cargo ansible zstd
}

install_docker_ubuntu() {
  echo "Ubuntu/Debian detected."
  sudo apt-get update
  sudo apt-get install -y cargo ansible
}

case "$OS_ID" in
  fedora)
    install_docker_fedora
    ;;
  ubuntu|debian)
    install_docker_ubuntu
    ;;
  *)
    echo "Unsupported OS: $OS_ID. Exiting."
    exit 1
    ;;
esac

# Verify installations
command -v cargo >/dev/null 2>&1 || { echo "Cargo installation failed" >&2; exit 1; }
command -v ansible >/dev/null 2>&1 || { echo "Ansible installation failed" >&2; exit 1; }

echo "Installation complete."


ansible-playbook -c local validator-node.yml -vv
