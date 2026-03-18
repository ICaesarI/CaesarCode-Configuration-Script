
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

### 🛠 A. Shell & Terminal Foundation
* **[Zsh](https://github.com/zsh-users/zsh):** Advanced shell with better scripting and auto-completion.
* **[Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh):** Framework for managing plugins and themes.
* **[Powerlevel10k](https://github.com/romkatv/powerlevel10k):** High-performance theme. *Note: Requires Hack Nerd Font for icons.*

### ⚡ B. Productivity Plugins (Zsh)
| Plugin | Description |
| :--- | :--- |
| **Autosuggestions** | Predicts commands based on your history. |
| **Syntax Highlighting** | Real-time color coding for terminal commands. |
| **FZF** | Intelligent fuzzy finder for files and processes (`Ctrl + R`). |

### 🐉 C. Modern CLI Utilities
* **[Fastfetch](https://github.com/fastfetch-cli/fastfetch):** System info with **Red Dragon** ASCII Art.
* **[LSD](https://github.com/lsd-rs/lsd):** `ls` on steroids with icons, colors, and tree mode.
* **[Bat](https://github.com/sharkdp/bat):** A `cat` clone with syntax highlighting and Git integration.
* **[Bottom (btm)](https://github.com/ClementTsang/bottom):** Modern graphical system monitor.
* **[Atuin](https://github.com/atuinsh/atuin):** Magical synced shell history search.

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