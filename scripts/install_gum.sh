#!/bin/bash

install_gum() {
    echo "[ ] Installing gum..."

    command -v gpg &>/dev/null || sudo apt-get install --yes gnupg

    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg

    if [[ ! -s /etc/apt/keyrings/charm.gpg ]]; then
        echo "[x] Failed to download/import the Charm gpg key. Aborting gum install." >&2
        return 1
    fi

    echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
    sudo apt-get update
    sudo apt-get install --yes gum

    echo "[✓] Installing gum..."
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    install_gum
fi
