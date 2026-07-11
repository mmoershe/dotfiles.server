# AGENTS.md

This file provides guidance to AI coding agents (Claude Code, and any other AGENTS.md-compatible tool) when working with code in this repository.

## What this repo is

Simple and basic dotfiles for my various Linux servers (often a Linux VPS I rent, running Debian).
This is a collection of shell scripts, GNU Stow packages, and package lists, driven by a single entry point.
It's not supposed to be super sophisticated or comprehensive, just make setting up a simple server and working with that a little more convenient.

## Entry Point (`entry.sh`)

Simple entry point for the user to access scripts conveniently.

```
bash entry.sh
```

This shows a `gum choose` menu with x actions:

## Scripts (`scripts/`)

### General rule regarding scripts

Every script in `scripts/` (including those under `scripts/special_installs/`)
follows the same "sourceable function" pattern:

- The script's real work lives in **a single function whose name matches the
  filename** without the `.sh` extension. E.g. `stow_all.sh` defines
  `stow_all()`, `install_packages.sh` defines `install_packages()`.
- No work happens at the top level. The file only _defines_ the function.
- A guard at the bottom calls the function only when the script is run
  directly, not when it's sourced:

  ```bash
  if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
      stow_all
  fi
  ```

**Why:** this lets each script be used two ways — run standalone
(`bash scripts/stow_all.sh`) for quick testing, _or_ sourced by another
script (like `entry.sh`) which then calls the function. `entry.sh` and the
scripts under `scripts/special_installs/` both rely on this: they source a
script and invoke its function.

When adding or editing a script, preserve this exact shape:

```bash
#!/bin/bash

my_script() {
    # ... work goes here ...
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    my_script
fi
```
