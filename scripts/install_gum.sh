#!/bin/bash

install_gum() {
    echo "[ ] Installing gum..."

    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
    echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
    sudo apt-get update
    sudo apt-get install --yes gum

    echo "[✓] Installing gum..."
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    install_gum
fi
