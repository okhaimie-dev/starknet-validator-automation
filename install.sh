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
  echo "Installing Docker on Fedora..."
  sudo dnf -y install dnf-plugins-core
  sudo dnf install -y zstd curl
  sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
  sudo dnf -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin
  sudo systemctl enable --now docker
}

install_docker_ubuntu() {
  echo "Installing Docker on Ubuntu..."
  sudo apt-get update
  sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common zstd
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
  sudo systemctl enable --now docker
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

echo "Preparing Juno snapshot directory..."
sudo mkdir -p /starknet/snapshots
sudo chown root:docker /starknet/snapshots
sudo chmod 770 /starknet/snapshots

echo "Downloading latest Juno snapshot..."
curl -sSL https://juno-snapshots.nethermind.io/files/sepolia/latest \
  | zstd -d | tar -xvf - -C /starknet/snapshots

echo "Pulling Juno Docker image..."
docker pull nethermind/juno
