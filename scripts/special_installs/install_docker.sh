#!/bin/bash

install_docker() {
    echo "[ ] Installing Docker..."

    echo "Uninstalling all conflicting packages..."
    for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do
        sudo apt-get remove --yes "$pkg"
    done

    echo "Setting up Docker's apt repository..."
    # Add Docker's official GPG key.
    sudo apt-get update
    sudo apt-get install --yes ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to apt sources.
    echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
        $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |
        sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
    sudo apt-get update

    echo "Installing Docker packages..."
    sudo apt-get install --yes docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    echo "[✓] Installing Docker..."
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    install_docker
fi
