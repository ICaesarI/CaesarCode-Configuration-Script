#!/bin/bash

# --- 0. Identificación de Rutas ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"

# --- 1. Dependencies & System Cleanup ---
sudo rm -f /etc/apt/sources.list.d/spotify.list /etc/apt/sources.list.d/warp.list
sudo apt update && sudo apt install -y \
    zsh git curl fzf tldr lsd chafa bat software-properties-common \
    python3 python3-pip python3-ipython unzip neofetch

# Fix para el nombre de 'bat' en Debian/Ubuntu
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat 2>/dev/null

# --- 2. Herramientas Externas & Fuentes ---

# 2.1 Hack Nerd Font
echo "Instalando Hack Nerd Font..."
FONT_DIR="$HOME/.local/share/fonts/HackNerdFont"
if [ ! -d "$FONT_DIR" ]; then
    mkdir -p "$FONT_DIR"
    curl -fLo /tmp/Hack.zip "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Hack.zip"
    unzip -o /tmp/Hack.zip -d "$FONT_DIR" > /dev/null
    rm /tmp/Hack.zip
    fc-cache -fv "$FONT_DIR" > /dev/null
    echo " [✓] Fuente instalada."
fi

# 2.2 Fastfetch
sudo add-apt-repository -y ppa:zhangsongcui3371/fastfetch
sudo apt update && sudo apt install -y fastfetch

# 2.3 Bottom (btm)
curl -LO "https://github.com/ClementTsang/bottom/releases/download/0.9.6/bottom_0.9.6_amd64.deb"
sudo dpkg -i bottom_0.9.6_amd64.deb && rm bottom_0.9.6_amd64.deb

# --- 3. Oh My Zsh & Powerlevel10k ---
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

ZSH_CUSTOM_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
P10K_DIR="$ZSH_CUSTOM_DIR/themes/powerlevel10k"
[[ ! -d "$P10K_DIR" ]] && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"

# --- 4. Plugins ---
[[ ! -d "$ZSH_CUSTOM_DIR/plugins/zsh-autosuggestions" ]] && git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM_DIR/plugins/zsh-autosuggestions"
[[ ! -d "$ZSH_CUSTOM_DIR/plugins/zsh-syntax-highlighting" ]] && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM_DIR/plugins/zsh-syntax-highlighting"

# --- 5. Atuin ---
if ! command -v atuin &> /dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://setup.atuin.sh | sh -s -- --accept-all
    export ATUIN_NOBIND="true" 
fi

# --- 6. Configuración de Fastfetch ---
mkdir -p ~/.config/fastfetch/
cat > ~/.config/fastfetch/config.jsonc << 'EOF'
{
    "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
    "logo": {
        "type": "builtin",
        "source": "garudadragon",
        "color": { "1": "red", "2": "red" },
        "padding": { "right": 4 }
    },
    "display": {
        "separator": " ➜  "
    },
    "modules": [
        "os", "kernel", "uptime", "packages", "shell", "terminal", "cpu", "memory", "break", "colors"
    ]
}
EOF

# --- 7. Inyección en .zshrc ---
sed -i '/typeset -g POWERLEVEL9K_INSTANT_PROMPT/d' ~/.zshrc
sed -i '/# --- START CUSTOM CONFIG ---/,/# --- END CUSTOM CONFIG ---/d' ~/.zshrc
sed -i '1i typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet' ~/.zshrc
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc

cat << 'EOF' >> ~/.zshrc

# --- START CUSTOM CONFIG ---
export PATH="$HOME/.atuin/bin:$PATH"
eval "$(atuin init zsh)"

[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh

# Aliases
alias ls='lsd'
alias ll='lsd -l'
alias la='lsd -a'
alias lt='lsd --tree'
alias cat='bat'
alias top='btm'
alias fetch='fastfetch'
alias neo='neofetch'
alias py='python3 -m IPython'

[ -d "$HOME/Desktop" ] && cd "$HOME/Desktop" || [ -d "$HOME/Escritorio" ] && cd "$HOME/Escritorio"

fastfetch
# --- END CUSTOM CONFIG ---
EOF

# --- 8. Finalización ---
tldr --update > /dev/null 2>&1
CURRENT_USER=$(whoami)
sudo chsh -s "$(which zsh)" "$CURRENT_USER"

echo "----------------------------------------------------------"
echo "   Setup Complete! Please restart your terminal."
echo "   Font: 'Hack Nerd Font Mono'"
echo "----------------------------------------------------------"