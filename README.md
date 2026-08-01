
# 🐉 CaesarCode: Red Dragon Configuration
> **High-Performance Linux Development Environment & VS Code Sync**

This repository provides an automated configuration to transform a standard Linux terminal (**Arch/Arch-based** y **Debian/Ubuntu/Kali**) into a high-performance environment with a striking **"Red Dragon"** aesthetic: animated TUI installer, red-on-black theme and a dynamic installation window.

---

## 🚀 1. Quick Start (Execution)

The installer handles dependencies, shell configuration, VS Code themes and extensions, and ends with an ASCII summary in a bordered box.

### Prerequisites
* Arch (pacman) or Debian-based (apt) distribution.
* `git` and `curl` installed.

### Installation
| Step | Action | Command |
| :--- | :--- | :--- |
| **1** | Clone the repo | `git clone https://github.com/ICaesarI/CaesarCode-Configuration-Script.git` |
| **2** | Enter directory | `cd CaesarCode-Configuration-Script` |
| **3** | Grant permissions | `chmod +x install.sh scripts/*.sh` |
| **4** | Run Installer | `./install.sh` |

### Options
| Flag | Description |
| :--- | :--- |
| `--dry-run` / `--check` / `-n` | Recorre todo el flujo (animaciones incluidas) **sin instalar ni modificar nada**. |
| `CC_NO_COLOR=1` | Desactiva colores (útil si se redirige la salida). |

---

## 🐳 2. Probarlo sin tocar tu sistema (Docker)

Puedes ejecutar la instalación completa en un contenedor desechable de Arch:

```bash
docker run --name cc-test -d archlinux:latest sleep infinity
docker exec cc-test pacman -Sy --noconfirm sudo
docker cp . cc-test:/opt/cc
docker exec -it cc-test bash -c "chmod +x /opt/cc/scripts/*.sh && cd /opt/cc && bash install.sh"

# Limpiar:
docker rm -f cc-test
```

> Usa `-it` para ver la TUI animada. Sin `-it` la salida es texto plano (sin códigos ANSI).

---

## 🐧 3. Ecosystem Components

### A. Shell & Terminal Foundation
* **Zsh:** Advanced shell with better scripting and auto-completion.
* **Oh My Zsh:** Framework for managing plugins and themes.
* **Powerlevel10k:** High-performance theme configured with "Instant Prompt" for speed.
* **Atuin:** Magical shell history search with SQLite backend.

### B. Productivity & Development
* **IPython:** Interactive Python shell with syntax highlighting and completion.
* **FZF:** Intelligent fuzzy finder for files and processes (`Ctrl + R`).
* **Fastfetch:** System info showing a custom "CaesarCode Config" ASCII dragon.

### C. Modern CLI Utilities
| Tool | Description |
| :--- | :--- |
| **Fastfetch** | Next-gen system info with Red Dragon ASCII Art. |
| **LSD** | Next-gen `ls` with icons and tree mode. |
| **Bat** | A `cat` clone with syntax highlighting and Git integration. |
| **Bottom (btm)** | Modern graphical system monitor. |

---

## 🎨 4. Installer UI

* Tema **negro + rojo sombreado** (banner con degradado).
* **Ventana dinámica** (`run_windowed`): el título, el paso actual y la barra de progreso quedan fijos arriba; abajo solo se muestran las últimas líneas del comando en ejecución.
* Spinners, barras de progreso y `type_text` animado.
* Resumen final con arte ASCII en caja de doble borde y paneles por sección.

Librería visual: `scripts/lib/ui.sh` (`cc_header`, `run_windowed`, `progress_bar`, `run_spinner`, `type_text`, `log_*`).

---

## 💻 5. VS Code Setup

1.  **Install recommended extensions (35):**
    ```bash
    ./scripts/install_extensions.sh   # genera scripts/install-ext.sh
    bash ./scripts/install-ext.sh
    ```
2.  **Sync `settings.json`:**
    ```bash
    ./scripts/update_settings.sh
    ```

---

## 📂 Project Structure

```text
CaesarCode-Configuration-Script/
├── 📄 install.sh                # Main installation entry point (TUI)
├── 📄 README.md                 # Documentation
├── 📁 configs/
│   ├── ⚙️ settings.json         # VS Code configuration
│   ├── 🐉 logo-caesarcode.txt   # ASCII dragon + "CaesarCode Config"
│   └── 🐉 dragon.txt            # Source ASCII Art
└── 📁 scripts/
    ├── 🐚 setup-zsh.sh          # Zsh, plugins, atuin, fastfetch (pacman/apt)
    ├── 🧩 install_extensions.sh # Genera el instalador de extensiones
    ├── 🧩 install-ext.sh        # Extensiones VS Code (generado)
    ├── 🔗 update_settings.sh    # Sincroniza configs/settings.json
    └── 📁 lib/
        └── 🎨 ui.sh             # Librería visual (tema rojo, ventana dinámica)
```
---

## 📊 Quick Aliases Summary

Once installed, use these shorthand commands for maximum efficiency:

| Tool | Original Command | **CaesarCode Alias** |
| :--- | :--- | :--- |
| **Fastfetch** | `fastfetch` | `fetch` |
| **LSD (List)** | `lsd -l` | `ll` |
| **LSD (Tree)** | `lsd --tree` | `lt` |
| **Bottom** | `btm` | `top` |
| **Batcat** | `batcat` | `cat` |
| **IPython** | `ipython` | `py` |

---

## ⚠️ Font Configuration (Important)

To ensure icons and symbols render correctly in both the terminal and VS Code, you **must** use a "Nerd Font."

👉 **Recommended:** [Hack Nerd Font Mono](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Hack.zip) (se instala automáticamente con `install.sh`).

---

## 📧 Contact & Contributions

Feel free to reach out or contribute to the project:

* **LinkedIn:** [Cesar Gonzalez](https://www.linkedin.com/in/cesargonzalez-dev)
* **GitHub:** [ICaesarI](https://github.com/ICaesarI)
* **Email:** [cesar.gonzalez.anayadev@gmail.com](mailto:cesar.gonzalez.anayadev@gmail.com)

---
