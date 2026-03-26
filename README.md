
# 🐉 CaesarCode: Red Dragon Configuration
> **High-Performance Linux Development Environment & VS Code Sync**

This repository provides an automated configuration to transform a standard Linux terminal (Debian/Ubuntu/Kali) into a high-performance environment, optimized for productivity with a striking **"Red Dragon"** aesthetic.

---

## 🚀 1. Quick Start (Execution)

Follow these steps to deploy the full environment. The installer handles dependencies, shell configuration, and VS Code themes.

### Prerequisites
* A Debian-based distribution (Ubuntu, Kali, Parrot, etc.).
* `git` and `curl` installed.

### Installation
| Step | Action | Command |
| :--- | :--- | :--- |
| **1** | Clone the repo | `git clone https://github.com/ICaesarI/CaesarCode-Configuration-Script.git` |
| **2** | Enter directory | `cd CaesarCode-Configuration-Script` |
| **3** | Grant permissions | `chmod +x install.sh scripts/*.sh` |
| **4** | Run Installer | `./install.sh` |

---

## 🐧 2. Ecosystem Components

### A. Shell & Terminal Foundation
* **Zsh:** Advanced shell with better scripting and auto-completion.
* **Oh My Zsh:** Framework for managing plugins and themes.
* **Powerlevel10k:** High-performance theme configured with "Instant Prompt" for speed.
* **Atuin:** Magical shell history search with SQLite backend.

### B. Productivity & Development
* **IPython:** Interactive Python shell with syntax highlighting and completion.
* **FZF:** Intelligent fuzzy finder for files and processes (`Ctrl + R`).
* **Highlight on Copy:** Visual feedback when copying text in VS Code (Red themed).

### C. Modern CLI Utilities
| Tool | Description |
| :--- | :--- |
| **Fastfetch** | Next-gen system info with Red Dragon ASCII Art. |
| **Neofetch** | Classic system information tool. |
| **LSD** | Next-gen `ls` with icons and tree mode. |
| **Bat** | A `cat` clone with syntax highlighting and Git integration. |
| **Bottom (btm)** | Modern graphical system monitor. |

---

## 💻 3. VS Code Setup

Sync your favorite editor using the included scripts:

1.  **Install recommended extensions:**
    ```bash
    ./scripts/install-ext.sh
    ```
2.  **Sync `settings.json`:**
    ```bash
    ./scripts/update-settings.sh
    ```
    *This links `configs/settings.json` to your local User folder.*

---

## 📂 Project Structure

```text
CaesarCode-Configuration-Script/
├── 📄 install.sh              # Main installation entry point
├── 📄 README.md               # Documentation
├── 📁 configs/
│   ├── ⚙️ settings.json       # Pro VS Code configuration
│   └── 🐉 dragon.txt          # Custom ASCII Art
└── 📁 scripts/
    ├── 🐚 setup-zsh.sh        # Zsh & Plugins logic
    ├── 🧩 install-ext.sh      # VS Code extensions installer
    └── 🔗 update-settings.sh  # Configuration symlinking
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
| **Neofetch** | `neofetch` | `neo` |

---

## ⚠️ Font Configuration (Important)

To ensure icons and symbols render correctly in both the terminal and VS Code, you **must** use a "Nerd Font."

👉 **Recommended:** [Hack Nerd Font Mono](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Hack.zip)

---

## 📧 Contact & Contributions

Feel free to reach out or contribute to the project:

* **LinkedIn:** [Cesar Gonzalez](https://www.linkedin.com/in/cesargonzalez-dev)
* **GitHub:** [ICaesarI](https://github.com/ICaesarI)
* **Email:** [cesar.gonzalez.anayadev@gmail.com](mailto:cesar.gonzalez.anayadev@gmail.com)

---