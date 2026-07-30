#!/bin/bash

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_DIR="$BASE_DIR/scripts"

if [[ -f /etc/os-release ]] && grep -qi '^ID=debian' /etc/os-release && ! command -v gum &>/dev/null; then
    read -rp "gum is not installed. Install it now? [y/N] " install_gum_answer
    if [[ "$install_gum_answer" =~ ^[Yy]$ ]]; then
        source "$SCRIPTS_DIR/install_gum.sh"
        install_gum
    fi
fi

options=(
    "update"
    "install packages"
    "stow all"
    "special install"
)

choice=$(gum choose --header="What would you like to do?" "${options[@]}")

[[ -z "$choice" ]] && {
    echo "No selection made. Exiting."
    exit 0
}

if [[ $choice == "update" ]]; then
    echo "sudo apt-get update -y"
    sudo apt-get update -y

    echo "sudo apt-get upgrade -y"
    sudo apt-get upgrade -y
fi

if [[ $choice == "install packages" ]]; then
    source "$SCRIPTS_DIR/install_packages.sh"
    install_packages
fi

if [[ $choice == "stow all" ]]; then
    source "$SCRIPTS_DIR/stow_all.sh"
    stow_all
fi

if [[ $choice == "special install" ]]; then
    source "$SCRIPTS_DIR/install_specials.sh"
    install_specials
fi
