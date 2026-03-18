#!/bin/bash

# Define paths
CONFIG_SOURCE="configs/settings.json"
SETTINGS_DIR="$HOME/.config/Code/User"
SETTINGS_TARGET="$SETTINGS_DIR/settings.json"

# Check if the source file exists
if [ ! -f "$CONFIG_SOURCE" ]; then
    echo "Error: $CONFIG_SOURCE not found. Please ensure the file exists."
    exit 1
fi

# Ensure the target directory exists
mkdir -p "$SETTINGS_DIR"

# Copy the configuration file
cp "$CONFIG_SOURCE" "$SETTINGS_TARGET"

echo "settings.json has been updated successfully."