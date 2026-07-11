#!/bin/bash

install_packages() {
    echo "[ ] Installing apt packages..."

    SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    BASE_DIR="$SCRIPTS_DIR/.."

    # Read package names, skipping blank lines and comments.
    packages=$(grep -vE '^\s*(#|$)' "$BASE_DIR/apt-packages.txt")

    sudo apt-get update && sudo apt-get install --yes $packages

    echo "[✓] Installing apt packages..."
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    install_packages
fi
