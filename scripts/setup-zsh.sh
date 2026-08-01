#!/bin/bash

# --- 0. Identificación de Rutas ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"

# --- Cargar librería visual ---
source "$SCRIPT_DIR/lib/ui.sh"

# --- 0. Modo dry-run / check ---
DRY_RUN=0
for _arg in "$@"; do
    case "$_arg" in
        --dry-run|--check|-n) DRY_RUN=1 ;;
    esac
done
if [ "$DRY_RUN" = 1 ]; then
    log_warn "MODO DRY-RUN: solo se comprueba. NO se instala ni modifica nada."
fi

# --- 1. Detectar gestor de paquetes ---
if command -v pacman >/dev/null 2>&1; then
    PM="pacman"
elif command -v apt-get >/dev/null 2>&1; then
    PM="apt"
else
    cc_header 1 7 "HERRAMIENTAS DEL SISTEMA"
    log_error "No se detectó pacman ni apt-get. Distribución no soportada."
    exit 1
fi

# --- Cabecera persistente con sub-pasos ---
SUB_STEPS=7
cc_header 1 7 "HERRAMIENTAS DEL SISTEMA"
type_text "Gestor de paquetes detectado: $PM" 0.02
sleep 0.2

# --- 2. Dependencias del sistema ---
case "$PM" in
    pacman)
        if [ "$DRY_RUN" = 1 ]; then
            log_info "DRY-RUN: se instalaría con pacman:"
            printf '   %s\n' zsh git curl fzf lsd chafa bat tldr bottom fastfetch fontconfig python python-pip ipython unzip
        else
            sudo -v
            run_windowed 1 7 "HERRAMIENTAS DEL SISTEMA" "Instalando herramientas del sistema (pacman)..." \
                sudo pacman -S --noconfirm --needed \
                    zsh git curl fzf lsd chafa bat tldr bottom fastfetch fontconfig \
                    python python-pip ipython unzip
        fi

        # Barra de progreso herramienta por herramienta
        tools=(zsh git fzf lsd chafa bat tldr bottom fastfetch ipython unzip)
        total=${#tools[@]}
        for i in "${!tools[@]}"; do
            pacman -Q "${tools[$i]}" >/dev/null 2>&1
            progress_bar $((i + 1)) "$total" "Verificando herramientas instaladas"
            sleep 0.12
        done
        printf "\r\033[2K"
        log_success "$total herramientas verificadas."
        ;;
    apt)
        if [ "$DRY_RUN" = 1 ]; then
            log_info "DRY-RUN: se instalaría con apt: zsh git curl fzf tldr lsd chafa bat fontconfig python3 python3-pip python3-ipython unzip neofetch"
        else
            sudo -v
            sudo rm -f /etc/apt/sources.list.d/spotify.list /etc/apt/sources.list.d/warp.list
            run_windowed 1 7 "HERRAMIENTAS DEL SISTEMA" "Actualizando repositorios (apt)..." sudo apt update
            run_windowed 1 7 "HERRAMIENTAS DEL SISTEMA" "Instalando herramientas (apt)..." \
                sudo apt install -y \
                    zsh git curl fzf tldr lsd chafa bat software-properties-common \
                    python3 python3-pip python3-ipython unzip neofetch fontconfig
            mkdir -p ~/.local/bin
            ln -s /usr/bin/batcat ~/.local/bin/bat 2>/dev/null
        fi
        log_success "Herramientas instaladas."
        ;;
esac

# --- 3. Oh My Zsh & Powerlevel10k ---
cc_header 2 7 "OH MY ZSH + POWERLEVEL10K"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    if [ "$DRY_RUN" = 1 ]; then
        log_info "DRY-RUN: se clonaría Oh My Zsh."
    else
        run_windowed 2 7 "OH MY ZSH + POWERLEVEL10K" "Instalando Oh My Zsh..." sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        log_success "Oh My Zsh instalado."
    fi
else
    log_success "Oh My Zsh ya presente."
fi

ZSH_CUSTOM_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
P10K_DIR="$ZSH_CUSTOM_DIR/themes/powerlevel10k"
if [ ! -d "$P10K_DIR" ]; then
    if [ "$DRY_RUN" = 1 ]; then
        log_info "DRY-RUN: se clonaría Powerlevel10k."
    else
        run_spinner "Instalando Powerlevel10k..." git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
        log_success "Powerlevel10k instalado."
    fi
else
    log_success "Powerlevel10k ya presente."
fi

# --- 4. Plugins ---
cc_header 3 7 "PLUGINS DE ZSH"
if [ ! -d "$ZSH_CUSTOM_DIR/plugins/zsh-autosuggestions" ]; then
    if [ "$DRY_RUN" = 1 ]; then
        log_info "DRY-RUN: se clonaría zsh-autosuggestions."
    else
        run_spinner "Instalando zsh-autosuggestions..." git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM_DIR/plugins/zsh-autosuggestions"
        log_success "zsh-autosuggestions instalado."
    fi
else
    log_success "zsh-autosuggestions ya presente."
fi
if [ ! -d "$ZSH_CUSTOM_DIR/plugins/zsh-syntax-highlighting" ]; then
    if [ "$DRY_RUN" = 1 ]; then
        log_info "DRY-RUN: se clonaría zsh-syntax-highlighting."
    else
        run_spinner "Instalando zsh-syntax-highlighting..." git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM_DIR/plugins/zsh-syntax-highlighting"
        log_success "zsh-syntax-highlighting instalado."
    fi
else
    log_success "zsh-syntax-highlighting ya presente."
fi

# --- 5. Atuin ---
cc_header 4 7 "ATUIN (HISTORIAL)"
if ! command -v atuin >/dev/null 2>&1 && [ ! -x "$HOME/.atuin/bin/atuin" ]; then
    if [ "$DRY_RUN" = 1 ]; then
        log_info "DRY-RUN: se instalaría Atuin (setup.atuin.sh)."
    else
        run_spinner "Descargando instalador de Atuin..." curl --proto '=https' --tlsv1.2 -sSfL --retry 3 -o /tmp/atuin-installer.sh https://github.com/atuinsh/atuin/releases/latest/download/atuin-installer.sh
        if [ -s /tmp/atuin-installer.sh ]; then
            run_windowed 4 7 "ATUIN (HISTORIAL)" "Instalando Atuin..." sh /tmp/atuin-installer.sh
            rm -f /tmp/atuin-installer.sh
        fi
        if [ -x "$HOME/.atuin/bin/atuin" ]; then
            log_success "Atuin instalado."
        else
            log_warn "No se pudo instalar Atuin. Prueba manual: curl https://setup.atuin.sh | sh"
        fi
    fi
else
    log_success "Atuin ya presente."
fi

# --- 6. Fastfetch (logo dragón + texto CaesarCode) ---
cc_header 5 7 "FASTFETCH (DRAGÓN)"
if [ "$DRY_RUN" = 1 ]; then
    log_info "DRY-RUN: se escribiría ~/.config/fastfetch/config.jsonc y el logo dragón."
else
    mkdir -p ~/.config/fastfetch/
    cp -f "$REPO_ROOT/configs/logo-caesarcode.txt" ~/.config/fastfetch/logo-caesarcode.txt
    LOGO_PATH="$HOME/.config/fastfetch/logo-caesarcode.txt"
    sed "s|__LOGO_PATH__|$LOGO_PATH|" << 'EOF' > ~/.config/fastfetch/config.jsonc
{
    "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
    "logo": {
        "type": "file",
        "source": "__LOGO_PATH__",
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
    log_success "Config de fastfetch (dragón + CaesarCode Config) creada."
fi

# --- 7. Inyección en .zshrc ---
cc_header 6 7 "INYECCIÓN EN .ZSHRC"
if [ "$DRY_RUN" = 1 ]; then
    log_info "DRY-RUN: se inyectaría el bloque custom en ~/.zshrc."
else
# 7.1 Limpiar bloque custom previo (por si ya corrió antes)
sed -i '/# --- START CUSTOM CONFIG ---/,/# --- END CUSTOM CONFIG ---/d' ~/.zshrc 2>/dev/null

# 7.2 Si no hay un .zshrc de oh-my-zsh, escribir la plantilla base
if ! grep -q "oh-my-zsh.sh" ~/.zshrc 2>/dev/null; then
    [ -f ~/.zshrc ] && cp ~/.zshrc ~/.zshrc.bak.$(date +%s)
    cat > ~/.zshrc << 'EOF'
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme: Powerlevel10k
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
EOF
fi

# 7.3 Bloque custom
cat << 'EOF' >> ~/.zshrc

# --- START CUSTOM CONFIG ---
export PATH="$HOME/.atuin/bin:$PATH"
[ -x "$HOME/.atuin/bin/atuin" ] && eval "$(atuin init zsh)"

[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh

# Aliases
alias ls='lsd'
alias ll='lsd -l'
alias la='lsd -a'
alias lt='lsd --tree'
alias cat='bat'
alias top='btm'
alias fetch='fastfetch'
if command -v neofetch >/dev/null 2>&1; then
    alias neo='neofetch'
else
    alias neo='fastfetch'
fi
alias py='python3 -m IPython'

[ -d "$HOME/Desktop" ] && cd "$HOME/Desktop" || [ -d "$HOME/Escritorio" ] && cd "$HOME/Escritorio"

fastfetch
# --- END CUSTOM CONFIG ---
EOF
fi

# --- 8. Finalización ---
cc_header 7 7 "FINALIZANDO"
if [ "$DRY_RUN" = 1 ]; then
    CURRENT_USER=$(whoami)
    log_info "DRY-RUN: se haría: chsh -s $(command -v zsh) $CURRENT_USER  y  tldr --update"
else
    type_text "Actualizando tldr..." 0.01
    tldr --update > /dev/null 2>&1
    CURRENT_USER=$(whoami)
    type_text "Definiendo zsh como shell por defecto..." 0.01
    sudo chsh -s "$(command -v zsh)" "$CURRENT_USER"
fi

echo
echo "----------------------------------------------------------"
if [ "$DRY_RUN" = 1 ]; then
    log_success "CHECK COMPLETADO: todo listo para instalar (no se tocó nada)."
else
    log_success "Setup de terminal completado."
    echo "   Fuente recomendada: 'Hack Nerd Font Mono'"
    echo "   Reinicia tu terminal (o escribe: zsh)"
fi
echo "----------------------------------------------------------"
