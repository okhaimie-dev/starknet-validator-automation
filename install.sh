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
  
  echo "Installing Docker for Fedora..."
  sudo dnf -y install dnf-plugins-core
  sudo dnf-3 config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
  sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  sudo systemctl enable --now docker
  sudo usermod -aG docker $USER
}

install_dependencies_ubuntu() {
  echo "Installing dependencies for Ubuntu/Debian..."
  sudo apt-get update
  sudo apt-get install -y ansible zstd curl
  
  echo "Installing Docker for Ubuntu/Debian..."
  sudo apt-get install -y ca-certificates curl
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  sudo systemctl enable --now docker
  sudo usermod -aG docker $USER
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
command -v docker >/dev/null 2>&1 || { echo "Docker installation failed" >&2; exit 1; }

echo "Dependencies installed successfully."
echo "Applying Docker group membership..."

# Apply new group membership for Docker
newgrp docker << EOF
echo "Docker group membership applied. Testing Docker access..."
docker --version || { echo "Docker not accessible after group change" >&2; exit 1; }
echo "Docker test successful!"

# Execute ansible playbook


ansible-playbook site.yml --tags all -c local