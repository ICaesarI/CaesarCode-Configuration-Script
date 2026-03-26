#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"

CONFIG_SOURCE="$REPO_ROOT/configs/settings.json"
SETTINGS_DIR="$HOME/.config/Code/User"
SETTINGS_TARGET="$SETTINGS_DIR/settings.json"

if [ ! -f "$CONFIG_SOURCE" ]; then
    echo "[!] Error: $CONFIG_SOURCE no encontrado."
    exit 1
fi

mkdir -p "$SETTINGS_DIR"

cp "$CONFIG_SOURCE" "$SETTINGS_TARGET"

echo "VS Code settings.json has been updated successfully from $CONFIG_SOURCE"