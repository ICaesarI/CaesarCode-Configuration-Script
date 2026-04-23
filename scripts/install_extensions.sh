cat << 'EOF' > scripts/install-ext.sh
#!/bin/bash

# List of optimized extensions (Clean Version)
extensions=(
    # --- UI & Experience ---
    "enkia.tokyo-night"           # Main Theme
    "pkief.material-icon-theme"   # Main Icons
    "0xtanzim.filetree-pro"       # Better File Tree
    "brandonkirbyson.vscode-animations" # Smooth animations
    "usernamehw.errorlens"        # Errors in line
    "oderwat.indent-rainbow"      # Colored indentation
    "mguellsegarra.highlight-on-copy" # Visual feedback on copy
    "yoavbls.pretty-ts-errors"    # Readable TS errors

    # --- Core Development Tools ---
    "eamodio.gitlens"             # Git supercharged
    "dbaeumer.vscode-eslint"      # Linting
    "esbenp.prettier-vscode"      # Formatting
    "formulahendry.auto-close-tag" # HTML/JSX productivity
    "formulahendry.code-runner"   # Run any snippet
    "pranaygp.vscode-css-peek"    # Go to CSS definitions
    "quicktype.quicktype"         # Generate types from JSON
    "wallabyjs.console-ninja"     # Console Ninja (Real-time logs)

    # --- Web & Frameworks (Astro, Django, React) ---
    "astro-build.astro-vscode"
    "batisteo.vscode-django"
    "thebarkman.vscode-djaneiro"  # Django snippets
    "dsznajder.es7-react-js-snippets" # Modern React/TS snippets
    "ritwickdey.liveserver"

    # --- Languages & Backend ---
    "ms-python.python"            # Python Full Pack
    "ms-python.vscode-pylance"
    "ms-python.debugpy"
    "ms-python.isort"
    "ms-vscode.cpptools-extension-pack" # C++ Full Pack
    "ms-dotnettools.csdevkit"     # C# Full Pack
    "ms-mssql.mssql"              # SQL Server / Databases

    # --- Containers & Remote ---
    "ms-azuretools.vscode-containers"
    "ms-vscode-remote.remote-containers"

    # --- Productivity ---
    "github.copilot-chat"
    "ms-vsliveshare.vsliveshare"
    "aaron-bond.better-comments"
    "tomoki1207.pdf"              # View PDFs inside VS
    "mechatroner.rainbow-csv"
)

echo "Starting the installation of your VS Code extensions..."
total=${#extensions[@]}
count=0

for ext in "${extensions[@]}"; do
    ((count++))
    echo -ne "\e[33m[$count/$total]\e[0m Installing: $ext...\r"
    code --install-extension "$ext" --force > /dev/null 2>&1
done
echo -e "\n"

echo "---------------------------------------------------"
echo "Extension installation complete!"
echo "Now you can sync your settings.json."
echo "---------------------------------------------------"
EOF