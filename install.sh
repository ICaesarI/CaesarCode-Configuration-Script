#!/bin/bash

# --- 0. Identificación de Rutas ---
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$BASE_DIR"

# --- Cargar librería visual ---
source ./scripts/lib/ui.sh

# --- Modo dry-run / check ---
DRY_RUN=0
for _arg in "$@"; do
    case "$_arg" in
        --dry-run|--check|-n) DRY_RUN=1 ;;
    esac
done

# --- Intro: título persistente ---
cc_header
type_text "Preparando CaesarCode Professional Environment..." 0.02
sleep 0.3

# Dar permisos de ejecución a todos los sub-scripts
chmod +x ./scripts/*.sh 2>/dev/null

TOTAL_STAGES=4
run_stage() {
    cc_header "$1" "$TOTAL_STAGES" "$2"
}

# --- ETAPA 1: TERMINAL & PYTHON ---
run_stage 1 "SHELL, TERMINAL Y HERRAMIENTAS"
if [ "$DRY_RUN" = 1 ]; then
    log_info "DRY-RUN: se llamaría a scripts/setup-zsh.sh (zsh, herramientas, plugins, atuin, fastfetch)."
elif [ -f "./scripts/setup-zsh.sh" ]; then
    if bash ./scripts/setup-zsh.sh "$@"; then
        log_success "Terminal, Python e IPython configurados correctamente."
    else
        log_error "Fallo en setup-zsh.sh"
    fi
else
    log_error "No se encontró scripts/setup-zsh.sh"
fi

# --- ETAPA 2: NERD FONTS (Hack Nerd Font) ---
run_stage 2 "HACK NERD FONT (ICONOS)"
FONT_DIR="$HOME/.local/share/fonts/HackNerdFont"

if [ "$DRY_RUN" = 1 ]; then
    log_info "DRY-RUN: se descargaría e instalaría Hack Nerd Font en $FONT_DIR"
elif [ ! -d "$FONT_DIR" ]; then
    mkdir -p "$FONT_DIR"
    run_spinner "Descargando glifos de Nerd Fonts..." curl -fLo /tmp/Hack.zip "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Hack.zip"
    if [ -f /tmp/Hack.zip ]; then
        unzip -o /tmp/Hack.zip -d "$FONT_DIR" > /dev/null
        rm /tmp/Hack.zip
        run_spinner "Actualizando caché de fuentes..." fc-cache -fv "$FONT_DIR"
        log_success "Hack Nerd Font instalada."
    else
        log_error "No se pudo descargar la fuente. Los iconos podrían no verse."
    fi
else
    log_success "Hack Nerd Font ya presente."
fi

# --- ETAPA 3: VS CODE EXTENSIONS ---
run_stage 3 "EXTENSIONES DE VS CODE"
if [ "$DRY_RUN" = 1 ]; then
    log_info "DRY-RUN: se generarían e instalarían las 35 extensiones de VS Code."
elif [ -f "./scripts/install_extensions.sh" ]; then
    run_spinner "Generando instalador de extensiones..." bash ./scripts/install_extensions.sh
    if [ -f "./scripts/install-ext.sh" ]; then
        if bash ./scripts/install-ext.sh; then
            log_success "Extensiones instaladas."
        else
            log_warn "Fallo en install-ext.sh (Normal si no hay entorno gráfico o code cli)"
        fi
    else
        log_info "Etapa 3 saltada (No existe install-ext.sh generado)"
    fi
else
    log_info "Etapa 3 saltada (No existe install_extensions.sh)"
fi

# --- ETAPA 4: SETTINGS SYNC ---
run_stage 4 "SINCRONIZANDO CONFIGURACIÓN"
if [ "$DRY_RUN" = 1 ]; then
    log_info "DRY-RUN: se copiaría configs/settings.json a ~/.config/Code/User/settings.json"
elif [ -f "./scripts/update_settings.sh" ]; then
    if bash ./scripts/update_settings.sh; then
        log_success "Configuración sincronizada."
    else
        log_error "Fallo en update_settings.sh"
    fi
else
    log_info "Etapa 4 saltada (No existe update_settings.sh)"
fi

cc_header 4 4 "RESUMEN FINAL"

if [ "$DRY_RUN" = 1 ]; then
    type_text "✓ CHECK COMPLETADO: todo listo para instalar (no se tocó nada)" 0.03
else
    type_text "✓ SETUP COMPLETE!" 0.03
fi
echo ""

# ─── Caja con el título ASCII ───
_HR="$(printf '═%.0s' {1..67})"
echo -e "${DARK_RED}  ╔${_HR}╗${RESET}"
while IFS= read -r _line; do
    printf '  %s %-65s %s\n' "${DARK_RED}║${RESET}" "${BOLD}${RED}$_line${RESET}" "${DARK_RED}║${RESET}"
done << 'EOF'
 _____   ___   _____ _____  ___  ______  _____ ___________ _____ 
/  __ \ / _ \ |  ___/  ___|/ _ \ | ___ \/  __ \  _  |  _  \  ___|
| /  \// /_\ \| |__ \ `--./ /_\ \| |_/ /| /  \/ | | | | | | |__  
| |    |  _  ||  __| `--. \  _  ||    / | |   | | | | | |  __| 
| \__/\| | | || |___/\__/ / | | || |\ \ | \__/\ \_/ / |/ /| |___ 
 \____/\_| |_/\____/\____/\_| |_/\_| \_| \____/\___/|___/ \____/
EOF
echo -e "${DARK_RED}  ╚${_HR}╝${RESET}"
echo ""

# ─── Helpers de panel ───
_DASH="$(printf '─%.0s' {1..56})"
pane_top()    { echo -e "${DARK_RED}  ┌${_DASH}┐${RESET}"; }
pane_bottom() { echo -e "${DARK_RED}  └${_DASH}┘${RESET}"; }
pane_line()   { printf '  %s %-54s %s\n' "${DARK_RED}│${RESET}" "$1" "${DARK_RED}│${RESET}"; }
pane_blank()  { pane_line ""; }

pane_top
pane_line "${BOLD}${BLOOD}[1] SHELL Y TERMINAL${RESET}"
pane_blank
pane_line " • zsh como shell por defecto"
pane_line " • Oh My Zsh + Powerlevel10k (prompt dragón)"
pane_line " • Plugins: autosuggestions + syntax-highlighting"
pane_line " • atuin: historial con búsqueda (Ctrl+R)"
pane_line " • Hack Nerd Font instalada (iconos)"
pane_bottom
echo ""

pane_top
pane_line "${BOLD}${BLOOD}[2] HERRAMIENTAS${RESET}"
pane_blank
pane_line " • fzf (búsqueda difusa), lsd (ls con colores), chafa"
pane_line " • bat (cat con sintaxis), tldr (man simplificado)"
pane_line " • btm / bottom (monitor del sistema), fastfetch"
pane_line " • Python + pip + IPython"
pane_bottom
echo ""

pane_top
pane_line "${BOLD}${BLOOD}[3] VS CODE${RESET}"
pane_blank
pane_line " • 35 extensiones (Tokyo Night, GitLens, ESLint,"
pane_line "   Prettier, Python, React, Copilot Chat, etc.)"
pane_line " • settings.json sincronizado"
pane_bottom
echo ""

pane_top
pane_line "${BOLD}${BLOOD}[4] COMO EMPEZAR${RESET}"
pane_blank
pane_line " 1. Cierra esta terminal y abre una nueva (o: zsh)"
pane_line " 2. Fuente: 'Hack Nerd Font Mono' en tu terminal"
pane_line " 3. Comandos útiles:"
pane_line "     ls / ll / la / lt  -> lsd (colores + árbol)"
pane_line "     cat                -> bat (sintaxis)"
pane_line "     top                -> btm (monitor)"
pane_line "     fetch / neo        -> fastfetch"
pane_line "     py                 -> IPython"
pane_line "     Ctrl+R             -> historial (fzf/atuin)"
pane_line "     ↑                  -> autosuggestions"
pane_line " 4. Escribe 'fastfetch' para ver tu dragón"
pane_bottom
echo ""

echo -e "${GREEN}${BOLD}  ¡Entorno CaesarCode listo! Disfrútalo.${RESET}"
echo -e "${DARK_RED}  ${_HR}${RESET}"
