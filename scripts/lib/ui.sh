#!/bin/bash
# CaesarCode UI library: animaciones y efectos visuales para la consola
# Tema: negro + rojo sombreado

# --- Colores (tema rojo/negro, compatibles con casi cualquier terminal) ---
# Con $'...' los escapes \e se vuelven ESC real, así funcionan tanto
# con echo -e como con printf '%s' (sin esto, printf imprime \e literal).
BLOOD=$'\e[1;31m'      # rojo brillante
RED=$'\e[31m'          # rojo
DARK_RED=$'\e[2;31m'   # rojo atenuado (sombreado)
GREEN=$'\e[32m'
YELLOW=$'\e[33m'
BOLD=$'\e[1m'
DIM=$'\e[2m'
RESET=$'\e[0m'

# --- Detección de terminal: si no hay TTY se desactivan colores y clear ---
CC_TTY=0
[ -t 1 ] && CC_TTY=1
if [ "$CC_TTY" != 1 ] || [ "${TERM:-dumb}" = "dumb" ] || [ -n "$CC_NO_COLOR" ]; then
    BLOOD=''; RED=''; DARK_RED=''; GREEN=''; YELLOW=''; BOLD=''; DIM=''; RESET=''
fi

# --- Logs con iconos ---
log_info()    { echo -e "${BLOOD}[i]${RESET} $1"; }
log_success() { echo -e "${GREEN}[✓]${RESET} $1"; }
log_warn()    { echo -e "${YELLOW}[!]${RESET} $1"; }
log_error()   { echo -e "${RED}[✗]${RESET} $1"; }

# --- Efecto de texto tecleándose ---
type_text() {
  local text="$1" delay="${2:-0.015}"
  for ((i = 0; i < ${#text}; i++)); do
    printf '%s' "${text:$i:1}"
    sleep "$delay"
  done
  echo
}

# --- Spinner (tarea en segundo plano) ---
_spinner_chars=(⠋ ⠙ ⠹ ⠸ ⠼ ⠴ ⠦ ⠧ ⠇ ⠏)
spinner() {
  local pid=$1 msg=$2 i=0
  while kill -0 "$pid" 2>/dev/null; do
    printf "\r${BLOOD}%s${RESET} %s" "${_spinner_chars[$((i % 10))]}" "$msg"
    i=$((i + 1))
    sleep 0.1
  done
  printf "\r\033[2K"
}

# --- Barra de progreso ---
progress_bar() {
  local current=$1 total=$2 label=$3 width=38
  local pct filled i
  pct=$((current * 100 / total))
  filled=$((current * width / total))
  [ "$pct" -gt 100 ] && pct=100
  [ "$filled" -gt "$width" ] && filled=$width
  printf "\r${DIM}%s${RESET} ${DARK_RED}[${RESET}" "$label"
  for ((i = 0; i < width; i++)); do
    if ((i < filled)); then printf "${BLOOD}█${RESET}"; else printf "${DIM}░${RESET}"; fi
  done
  printf "${DARK_RED}]${RESET} %3d%%" "$pct"
}

# --- Ejecutar comando con spinner ---
run_spinner() {
  local label="$1"
  shift
  "$@" >/dev/null 2>&1 &
  local pid=$!
  spinner "$pid" "$label"
  wait "$pid"
  return $?
}

# --- Cabecera persistente (título CaesarCode degradado + barra de estado) ---
# Uso: cc_header [paso] [total] [titulo]
cc_header() {
  local step="${1:-}" total="${2:-}" title="${3:-}"
  [ "$CC_TTY" = 1 ] && clear
  echo -e "${BOLD}"
  echo -e "${BLOOD} ██████╗ █████╗ ███████╗███████╗ █████╗ ██████╗      ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗ ${RESET}"
  echo -e "${BLOOD}██╔════╝██╔══██╗██╔════╝██╔════╝██╔══██╗██╔══██╗      ██╔════╝██╔═══██╗████╗  ██║██╔════╝██║██╔════╝ ${RESET}"
  echo -e "${RED}██║     ███████║█████╗  ███████║███████║██████╔╝█████╗██║     ██║   ██║██╔██╗ ██║█████╗  ██║██║  ███╗${RESET}"
  echo -e "${RED}██║     ██╔══██║██╔══╝  ╚════██║██╔══██║██╔══██╗╚════╝██║     ██║   ██║██║╚██╗██║██╔══╝  ██║██║   ██║${RESET}"
  echo -e "${DARK_RED}╚██████╗██║  ██║███████╗███████║██║  ██║██║  ██║      ╚██████╗╚██████╔╝██║ ╚████║██║     ██║╚██████╔╝${RESET}"
  echo -e "${DARK_RED} ╚═════╝╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝       ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝ ${RESET}"
  echo -e "${RESET}"
  if [ -n "$step" ]; then
    echo -e "  ${BOLD}${BLOOD}PASO ${step}/${total}  ${title}${RESET}"
    progress_bar "$step" "$total" "Progreso global"
    echo ""
  fi
  echo -e "${DARK_RED}${BOLD}──────────────────────────────────────────────────────────────${RESET}"
  echo
}

# --- Ventana dinámica: título fijo + solo las últimas líneas del comando ---
# Uso: run_windowed paso total titulo label comando [args...]
run_windowed() {
  local step=$1 total=$2 title=$3 label=$4
  shift 4
  local log pid rc
  log=$(mktemp)
  "$@" >"$log" 2>&1 &
  pid=$!
  rc=0
  while kill -0 "$pid" 2>/dev/null; do
    cc_header "$step" "$total" "$title"
    printf "${DIM}%s${RESET}\n" "$label"
    tail -n 14 "$log" | sed 's/^/   /'
    sleep 0.4
  done
  wait "$pid"
  rc=$?
  cc_header "$step" "$total" "$title"
  printf "${DIM}%s${RESET}\n" "$label"
  tail -n 14 "$log" | sed 's/^/   /'
  rm -f "$log"
  return $rc
}

# --- Encabezado de paso (compat) ---
step_header() {
  local n=$1 total=$2 title=$3
  echo
  echo -e "${BOLD}${DARK_RED}════════════════════════════════════════════════${RESET}"
  echo -e "${BOLD}${BLOOD}  ➜  PASO ${n}/${total}  ${title}${RESET}"
  echo -e "${BOLD}${DARK_RED}════════════════════════════════════════════════${RESET}"
}
