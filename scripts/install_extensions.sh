#!/bin/bash

# List of your extensions
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
    "visualstudiotoolsforunity.vstuc" "wallabyjs.quokka-vscode"
)

echo "Starting the installation of your VS Code extensions..."
total=${#extensions[@]}
count=0

for ext in "${extensions[@]}"; do
    ((count++))
    # Esto imprime: [1/57] Installing: 0xtanzim.filetree-pro
    echo -ne "\e[33m[$count/$total]\e[0m Installing: $ext...\r"
    code --install-extension "$ext" --force > /dev/null
done
echo -e "\n"

echo "---------------------------------------------------"
echo "Installation complete! Restart VS Code to apply changes."