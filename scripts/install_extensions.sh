cat << 'EOF' > scripts/install-ext.sh
#!/bin/bash

# List of your extensions (Full Version)
extensions=(
    "0xtanzim.filetree-pro" "aaron-bond.better-comments" "adpyke.codesnap" 
    "astro-build.astro-vscode" "batisteo.vscode-django" "be5invis.vscode-custom-css" 
    "beardedbear.beardedicons" "brandonkirbyson.vscode-animations" "burkeholland.simple-react-snippets" 
    "cardinal90.multi-cursor-case-preserve" "dbaeumer.vscode-eslint" "dsznajder.es7-react-js-snippets" 
    "eamodio.gitlens" "eliverlara.andromeda" "enkia.tokyo-night" 
    "esbenp.prettier-vscode" "formulahendry.auto-close-tag" "formulahendry.code-runner" 
    "github.copilot-chat" "kisstkondoros.vscode-gutter-preview" "lirobi.phone-preview" 
    "mechatroner.rainbow-csv" "ms-azuretools.vscode-containers" "ms-ceintl.vscode-language-pack-es" 
    "ms-dotnettools.csdevkit" "ms-dotnettools.csharp" "ms-dotnettools.vscode-dotnet-runtime" 
    "ms-mssql.data-workspace-vscode" "ms-mssql.mssql" "ms-mssql.sql-bindings-vscode" 
    "ms-mssql.sql-database-projects-vscode" "ms-python.debugpy" "ms-python.isort" 
    "ms-python.python" "ms-python.vscode-pylance" "ms-python.vscode-python-envs" 
    "ms-vscode-remote.remote-containers" "ms-vscode.cmake-tools" "ms-vscode.cpp-devtools" 
    "ms-vscode.cpptools" "ms-vscode.cpptools-extension-pack" "ms-vscode.cpptools-themes" 
    "ms-vscode.makefile-tools" "ms-vscode.powershell" "ms-vsliveshare.vsliveshare" 
    "oderwat.indent-rainbow" "pranaygp.vscode-css-peek" "quicktype.quicktype" 
    "rafamel.subtle-brackets" "ritwickdey.liveserver" "sketchbuch.vsc-quokka-statusbar" 
    "thebarkman.vscode-djaneiro" "tomoki1207.pdf" "usernamehw.errorlens" 
    "visualstudiotoolsforunity.vstuc" "wallabyjs.quokka-vscode" "yoavbls.pretty-ts-errors"
    "mguellsegarra.highlight-on-copy" "pkief.material-icon-theme"
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

# --- Visual Configuration (Highlight on Copy & Material Icons) ---
SETTINGS_PATH="$HOME/.config/Code/User/settings.json"
mkdir -p "$(dirname "$SETTINGS_PATH")"

cat << 'JSON' > "$SETTINGS_PATH"
{
    "workbench.iconTheme": "material-icon-theme",
    "workbench.colorTheme": "Andromeda",
    "highlight-on-copy.backgroundColor": "rgba(255, 0, 0, 0.4)",
    "highlight-on-copy.borderColor": "red",
    "highlight-on-copy.borderWidth": "1px",
    "highlight-on-copy.duration": 200,
    "material-icon-theme.activeIconPack": "react_redux",
    "material-icon-theme.folders.theme": "specific",
    "animations.enabled": true,
    "errorLens.enabled": true,
    "editor.guides.bracketPairs": "active",
    "editor.formatOnSave": true
}
JSON

echo "---------------------------------------------------"
echo "Installation complete! Settings applied correctly."
echo "Restart VS Code to apply changes."
echo "---------------------------------------------------"
EOF