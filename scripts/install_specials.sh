#!/bin/bash

install_specials() {
    SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    SPECIALS_DIR="$SCRIPTS_DIR/special_installs"

    # Build a menu from the scripts in special_installs/. Thanks to the naming
    # convention, each script's basename is also the name of the function it
    # defines, so the menu label doubles as the function to call.
    options=()
    for script in "$SPECIALS_DIR"/*.sh; do
        options+=("$(basename "$script" .sh)")
    done

    choice=$(gum choose --header="Which special install?" "${options[@]}")

    [[ -z "$choice" ]] && {
        echo "No selection made."
        return 0
    }

    source "$SPECIALS_DIR/$choice.sh"
    "$choice"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    install_specials
fi
