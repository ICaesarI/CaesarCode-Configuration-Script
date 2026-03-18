#!/bin/bash

# --- 0. Identificación de Rutas ---
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$BASE_DIR"

clear
# Nuevo Banner ASCII Estilo "Raw Shell"
cat << 'EOF'
 ██████╗ █████╗ ███████╗███████╗ █████╗ ██████╗        ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗ 
██╔════╝██╔══██╗██╔════╝██╔════╝██╔══██╗██╔══██╗       ██╔════╝██╔═══██╗████╗  ██║██╔════╝██║██╔════╝ 
██║     ███████║█████╗  ███████║███████║██████╔╝█████╗██║     ██║   ██║██╔██╗ ██║█████╗  ██║██║  ███╗
██║     ██╔══██║██╔══╝  ╚════██║██╔══██║██╔══██╗╚════╝██║     ██║   ██║██║╚██╗██║██╔══╝  ██║██║   ██║
╚██████╗██║  ██║███████╗███████║██║  ██║██║  ██║       ╚██████╗╚██████╔╝██║ ╚████║██║     ██║╚██████╔╝
 ╚═════╝╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝        ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝ 
                                  CONFIGURATION SCRIPT
EOF

# Funciones de Log con colores
log_info()    { echo -e "\e[34m[INFO]\e[0m $1"; }
log_success() { echo -e "\e[32m[✓]\e[0m $1"; }
log_error()   { echo -e "\e[31m[!] $1\e[0m"; }
log_warn()    { echo -e "\e[33m[WARN]\e[0m $1"; }

echo "=========================================================="
echo "Starting CaesarCode Professional Environment Setup..."
echo "=========================================================="

# Dar permisos de ejecución a todos los sub-scripts
chmod +x ./scripts/*.sh 2>/dev/null

# --- ETAPA 1: TERMINAL & PYTHON ---
log_info "Etapa 1: Instalando Terminal, Python e IPython..."
if [ -f "./scripts/setup-zsh.sh" ]; then
    if bash ./scripts/setup-zsh.sh; then
        log_success "Terminal e IPython configurados correctamente."
    else
        log_error "Fallo en setup-zsh.sh"
    fi
else
    log_error "No se encontró scripts/setup-zsh.sh"
fi

# --- ETAPA 2: NERD FONTS (Hack Nerd Font) ---
log_info "Etapa 2: Instalando Hack Nerd Font para Iconos..."
FONT_DIR="$HOME/.local/share/fonts/HackNerdFont"

if [ ! -d "$FONT_DIR" ]; then
    mkdir -p "$FONT_DIR"
    log_info "Descargando glifos de Nerd Fonts..."
    if curl -fLo /tmp/Hack.zip "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Hack.zip"; then
        unzip -o /tmp/Hack.zip -d "$FONT_DIR" > /dev/null
        rm /tmp/Hack.zip
        fc-cache -fv "$FONT_DIR" > /dev/null
        log_success "Hack Nerd Font instalada."
    else
        log_error "No se pudo descargar la fuente. Los iconos podrían no verse."
    fi
else
    log_success "Hack Nerd Font ya presente."
fi

# --- ETAPA 3: VS CODE EXTENSIONS ---
log_info "Etapa 3: Instalando extensiones VS Code..."
if [ -f "./scripts/install-ext.sh" ]; then
    if bash ./scripts/install-ext.sh; then
        log_success "Extensiones instaladas."
    else
        log_warn "Fallo en install-ext.sh (Normal si no hay entorno gráfico o code cli)"
    fi
else
    log_info "Etapa 3 saltada (No existe install-ext.sh)"
fi

# --- ETAPA 4: SETTINGS SYNC ---
log_info "Etapa 4: Sincronizando configuraciones..."
if [ -f "./scripts/update-settings.sh" ]; then
    if bash ./scripts/update-settings.sh; then
        log_success "Configuración sincronizada."
    else
        log_error "Fallo en update-settings.sh"
    fi
else
    log_info "Etapa 4 saltada (No existe update-settings.sh)"
fi

echo "=========================================================="
log_success "SETUP COMPLETE!"
echo ""
log_warn "IMPORTANT: Change your terminal font to 'Hack Nerd Font Mono'"
log_warn "to see icons and the dragon correctly."
echo ""
echo "Please restart your terminal or type 'zsh' to enter."
echo "=========================================================="