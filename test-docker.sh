#!/bin/bash
# CaesarCode — Prueba la instalación completa en un contenedor Docker desechable
# Uso:
#   ./test-docker.sh            # instalación completa (interactiva, a color)
#   ./test-docker.sh --dry-run  # recorre el flujo visual sin instalar nada
#   ./test-docker.sh --keep     # no elimina el contenedor al terminar

set -euo pipefail

DRY_RUN=0
KEEP=0
ARGS=()
for _arg in "$@"; do
    case "$_arg" in
        --dry-run|--check|-n) DRY_RUN=1 ;;
        --keep) KEEP=1 ;;
        *) ARGS+=("$_arg") ;;
    esac
done

CONTAINER="${CC_TEST_CONTAINER:-cc-test}"

# --- Terminal interactiva (colores/TUI) o no ---
IT="-i"
[ -t 0 ] && [ -t 1 ] && IT="-it"

if ! command -v docker > /dev/null 2>&1; then
    echo "✗ docker no está instalado" >&2
    exit 1
fi

cleanup() {
    [ "$KEEP" = 1 ] || docker rm -f "$CONTAINER" > /dev/null 2>&1 || true
}
trap cleanup EXIT

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "→ Preparando contenedor $CONTAINER ..."
docker rm -f "$CONTAINER" > /dev/null 2>&1 || true
docker run --name "$CONTAINER" -d archlinux:latest sleep infinity > /dev/null
docker exec "$CONTAINER" pacman -Sy --noconfirm sudo > /dev/null
docker cp "$BASE_DIR" "$CONTAINER:/opt/cc"
docker exec "$CONTAINER" bash -c 'chmod +x /opt/cc/scripts/*.sh'

EXTRA=()
[ "$DRY_RUN" = 1 ] && EXTRA=(--dry-run)
docker exec $IT "$CONTAINER" bash -c "cd /opt/cc && bash install.sh ${EXTRA[*]:-} ${ARGS[*]:-}"
