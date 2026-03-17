# 🐧 Professional Development Environment Setup
> High-Performance Linux Terminal + VS Code Configuration

This repository provides a reproducible Linux development environment designed to improve terminal productivity and developer workflow using modern CLI tools and a fully configured VS Code environment.

**Supported distributions:**
- Debian
- Ubuntu
- Kali Linux

This environment focuses on:
- Modern terminal workflow
- Advanced shell productivity
- Powerful CLI utilities
- Fully synchronized VS Code configuration

---

## 🐧 1. Automated Deployment
# 🐧 Professional Development Environment Setup
> High-Performance Linux Terminal + VS Code Configuration

This repository provides a reproducible Linux development environment designed to improve terminal productivity and developer workflow using modern CLI tools and a fully configured VS Code environment.

**Supported distributions:**
- Debian
- Ubuntu
- Kali Linux

This environment focuses on:
- Modern terminal workflow
- Advanced shell productivity
- Powerful CLI utilities
- Fully synchronized VS Code configuration

---

## 🐧 1. Automated Deployment

The fastest way to configure the full environment is using the master installation script.

**Instalación:**
```bash
chmod +x install.sh
./install.sh

Run installer:
```bash
./install.sh
```

This script will automatically configure:
- Zsh shell
- Oh My Zsh framework
- Terminal plugins
- CLI productivity tools
- VS Code extensions
- VS Code configuration

---

## 🐧 2. Manual Modular Installation

If you prefer installing each tool individually, follow the sections below.

---

### 🐧 A. Terminal Foundation

#### Zsh Shell
> [GitHub Repository](https://github.com/zsh-users/zsh)

Zsh is an advanced shell designed to replace Bash with improved usability, scripting capabilities, and plugin support.

Install Zsh:
```bash
sudo apt update
sudo apt install zsh -y
```

Verify installation:
```bash
zsh --version
```

Set Zsh as default shell:
```bash
chsh -s $(which zsh)
```
> Log out and log back in for the change to take effect.

---

#### Oh My Zsh
> [GitHub Repository](https://github.com/ohmyzsh/ohmyzsh)

Oh My Zsh is a framework for managing Zsh configuration with themes and plugins.

Install:
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Configuration file: `~/.zshrc`

Example plugin config:
```bash
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
```

---

#### Zsh Autosuggestions
> [GitHub Repository](https://github.com/zsh-users/zsh-autosuggestions)

Provides real-time command suggestions based on shell history.

Installation:
```bash
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

Enable plugin in `.zshrc`:
```bash
plugins=(git zsh-autosuggestions)
```

Reload configuration:
```bash
source ~/.zshrc
```

---

#### Zsh Syntax Highlighting
> [GitHub Repository](https://github.com/zsh-users/zsh-syntax-highlighting)

Adds syntax highlighting to terminal commands.

Installation:
```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

Enable plugin:
```bash
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
```

Reload configuration:
```bash
source ~/.zshrc
```

---

#### Powerlevel10k Theme
> [GitHub Repository](https://github.com/romkatv/powerlevel10k)

Powerlevel10k is a high-performance Zsh prompt with extensive customization.

Clone theme:
```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

Enable theme in `.zshrc`:
```bash
ZSH_THEME="powerlevel10k/powerlevel10k"
```

Run configuration wizard:
```bash
p10k configure
```

---

### 🐧 B. Modern Terminal Utilities

#### LSD (Modern ls replacement)
> [GitHub Repository](https://github.com/lsd-rs/lsd)

Provides icons, colors, and improved file listing.

Installation:
```bash
sudo apt install lsd
```

Recommended alias:
```bash
alias ls='lsd'
```

---

#### Bat (Modern cat replacement)
> [GitHub Repository](https://github.com/sharkdp/bat)

Adds syntax highlighting and Git integration to file viewing.

Install:
```bash
sudo apt install bat
```

Fix Ubuntu binary naming:
```bash
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat
```

Alias:
```bash
alias cat='bat'
```

---

#### Chafa (Terminal Image Renderer)
> [GitHub Repository](https://github.com/hpjansson/chafa)

Allows images to be rendered directly in the terminal.

Installation:
```bash
sudo apt install chafa
```

Usage example:
```bash
chafa image.jpg
```

---

#### FZF (Fuzzy Finder)
> [GitHub Repository](https://github.com/junegunn/fzf)

Provides interactive fuzzy searching for files, directories, and command history.

Installation:
```bash
sudo apt install fzf
```

Enable keybindings:
```bash
source /usr/share/doc/fzf/examples/key-bindings.zsh
```

Example usage — `CTRL + R` for interactive history search.

---

#### TLDR (Simplified Man Pages)
> [GitHub Repository](https://github.com/tldr-pages/tldr)

Provides simplified examples of common command usage.

Installation:
```bash
sudo apt install tldr
```

Update command pages:
```bash
tldr --update
```

Example:
```bash
tldr tar
```

---

### 🐧 C. Advanced Productivity Tools

#### Fastfetch
> [GitHub Repository](https://github.com/fastfetch-cli/fastfetch)

Displays system information in a fast and customizable format.

Installation:
```bash
sudo add-apt-repository ppa:zhangsongcui3371/fastfetch
sudo apt update
sudo apt install fastfetch
```

Run:
```bash
fastfetch
```

> Optional: add `fastfetch` to `.zshrc` to show on every terminal launch.

---

#### Bottom (Modern system monitor)
> [GitHub Repository](https://github.com/ClementTsang/bottom)

An advanced alternative to `top` or `htop`.

Download latest release from: https://github.com/ClementTsang/bottom/releases

Install:
```bash
sudo dpkg -i bottom*.deb
```

Alias:
```bash
alias top='btm'
```

Run:
```bash
btm
```

---

#### Atuin (Shell History Sync)
> [GitHub Repository](https://github.com/atuinsh/atuin)

Stores and synchronizes shell history across machines.

Install:
```bash
curl https://raw.githubusercontent.com/atuinsh/atuin/main/install.sh | bash
```

Enable integration:
```bash
eval "$(atuin init zsh)"
```

Register:
```bash
atuin register
```

Login:
```bash
atuin login
```

---

## 🐧 3. VS Code Setup

### Extensions Installation

Run the extension installer script:
```bash
chmod +x scripts/install-ext.sh
./scripts/install-ext.sh
```

Typical extensions installed:
- Docker
- GitLens
- Python
- SQLTools
- Markdown Preview Enhanced

### VS Code Settings Synchronization

Configuration file: `configs/settings.json`

Sync command:
```bash
scripts/update-settings.sh
```

Destination:
```
~/.config/Code/User/settings.json
```

---

## 🐧 Repository Structure

```
my-environment/
├── install.sh             
├── README.md
├── configs/
│   ├── settings.json      
│   └── dragon.txt          
└── scripts/
    ├── setup-zsh.sh        
    ├── install-ext.sh     
    └── update-settings.sh  
```

---

## 🐧 Configuration Summary

## 🐧 Configuration Summary

| Tool | Original Command | Zsh Alias | Function |
| :--- | :--- | :--- | :--- |
| **LSD** | `lsd` | `ls`, `ll`, `la`, `lt` | Modern file listing & trees |
| **Bat** | `bat` | `cat` | Syntax highlighting for files |
| **Bottom** | `btm` | `top` | Graphical system monitor |
| **Fastfetch** | `fastfetch` | `fetch` | System info + Dragon Art |
| **Atuin** | `atuin` | `Ctrl + R` | Magical shell history search |

---

## 🐧 Final Notes

This development environment provides:
- Faster terminal workflows
- Modern CLI utilities
- Powerful command history search
- Fully synchronized VS Code setup
- Modular and reproducible configuration


## 📧 Contact

Feel free to reach out or contribute:

-   **LinkedIn:** Cesar Gonzalez
-   **GitHub:** ICaesarI
-   **Email:** cesar.gonzalez.anayadev@gmail.com
The fastest way to configure the full environment is using the master installation script.

Give execution permissions:
```bash
chmod +x install.sh scripts/*.sh
```

Run installer:
```bash
./install.sh
```

This script will automatically configure:
- Zsh shell
- Oh My Zsh framework
- Terminal plugins
- CLI productivity tools
- VS Code extensions
- VS Code configuration

---

## 🐧 2. Manual Modular Installation

If you prefer installing each tool individually, follow the sections below.

---

### 🐧 A. Terminal Foundation

#### Zsh Shell
> [GitHub Repository](https://github.com/zsh-users/zsh)

Zsh is an advanced shell designed to replace Bash with improved usability, scripting capabilities, and plugin support.

Install Zsh:
```bash
sudo apt update
sudo apt install zsh -y
```

Verify installation:
```bash
zsh --version
```

Set Zsh as default shell:
```bash
chsh -s $(which zsh)
```
> Log out and log back in for the change to take effect.

---

#### Oh My Zsh
> [GitHub Repository](https://github.com/ohmyzsh/ohmyzsh)

Oh My Zsh is a framework for managing Zsh configuration with themes and plugins.

Install:
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Configuration file: `~/.zshrc`

Example plugin config:
```bash
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
```

---

#### Zsh Autosuggestions
> [GitHub Repository](https://github.com/zsh-users/zsh-autosuggestions)

Provides real-time command suggestions based on shell history.

Installation:
```bash
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

Enable plugin in `.zshrc`:
```bash
plugins=(git zsh-autosuggestions)
```

Reload configuration:
```bash
source ~/.zshrc
```

---

#### Zsh Syntax Highlighting
> [GitHub Repository](https://github.com/zsh-users/zsh-syntax-highlighting)

Adds syntax highlighting to terminal commands.

Installation:
```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

Enable plugin:
```bash
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
```

Reload configuration:
```bash
source ~/.zshrc
```

---

#### Powerlevel10k Theme
> [GitHub Repository](https://github.com/romkatv/powerlevel10k)

Powerlevel10k is a high-performance Zsh prompt with extensive customization.

Clone theme:
```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

Enable theme in `.zshrc`:
```bash
ZSH_THEME="powerlevel10k/powerlevel10k"
```

Run configuration wizard:
```bash
p10k configure
```

---

### 🐧 B. Modern Terminal Utilities

#### LSD (Modern ls replacement)
> [GitHub Repository](https://github.com/lsd-rs/lsd)

Provides icons, colors, and improved file listing.

Installation:
```bash
sudo apt install lsd
```

Recommended alias:
```bash
alias ls='lsd'
```

---

#### Bat (Modern cat replacement)
> [GitHub Repository](https://github.com/sharkdp/bat)

Adds syntax highlighting and Git integration to file viewing.

Install:
```bash
sudo apt install bat
```

Fix Ubuntu binary naming:
```bash
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat
```

Alias:
```bash
alias cat='bat'
```

---

#### Chafa (Terminal Image Renderer)
> [GitHub Repository](https://github.com/hpjansson/chafa)

Allows images to be rendered directly in the terminal.

Installation:
```bash
sudo apt install chafa
```

Usage example:
```bash
chafa image.jpg
```

---

#### FZF (Fuzzy Finder)
> [GitHub Repository](https://github.com/junegunn/fzf)

Provides interactive fuzzy searching for files, directories, and command history.

Installation:
```bash
sudo apt install fzf
```

Enable keybindings:
```bash
source /usr/share/doc/fzf/examples/key-bindings.zsh
```

Example usage — `CTRL + R` for interactive history search.

---

#### TLDR (Simplified Man Pages)
> [GitHub Repository](https://github.com/tldr-pages/tldr)

Provides simplified examples of common command usage.

Installation:
```bash
sudo apt install tldr
```

Update command pages:
```bash
tldr --update
```

Example:
```bash
tldr tar
```

---

### 🐧 C. Advanced Productivity Tools

#### Fastfetch
> [GitHub Repository](https://github.com/fastfetch-cli/fastfetch)

Displays system information in a fast and customizable format.

Installation:
```bash
sudo add-apt-repository ppa:zhangsongcui3371/fastfetch
sudo apt update
sudo apt install fastfetch
```

Run:
```bash
fastfetch
```

> Optional: add `fastfetch` to `.zshrc` to show on every terminal launch.

---

#### Bottom (Modern system monitor)
> [GitHub Repository](https://github.com/ClementTsang/bottom)

An advanced alternative to `top` or `htop`.

Download latest release from: https://github.com/ClementTsang/bottom/releases

Install:
```bash
sudo dpkg -i bottom*.deb
```

Alias:
```bash
alias top='btm'
```

Run:
```bash
btm
```

---

#### Atuin (Shell History Sync)
> [GitHub Repository](https://github.com/atuinsh/atuin)

Stores and synchronizes shell history across machines.

Install:
```bash
curl https://raw.githubusercontent.com/atuinsh/atuin/main/install.sh | bash
```

Enable integration:
```bash
eval "$(atuin init zsh)"
```

Register:
```bash
atuin register
```

Login:
```bash
atuin login
```

---

## 🐧 3. VS Code Setup

### Extensions Installation

Run the extension installer script:
```bash
chmod +x scripts/install-ext.sh
./scripts/install-ext.sh
```

Typical extensions installed:
- Docker
- GitLens
- Python
- SQLTools
- Markdown Preview Enhanced

### VS Code Settings Synchronization

Configuration file: `configs/settings.json`

Sync command:
```bash
scripts/update-settings.sh
```

Destination:
```
~/.config/Code/User/settings.json
```

---

## 🐧 Repository Structure

```
my-environment/
│
├── install.sh
├── README.md
│
├── configs/
│   └── settings.json
│
└── scripts/
    ├── setup-zsh.sh
    ├── install-ext.sh
    └── update-settings.sh
```

---

## 🐧 Configuration Summary

| Tool          | Command                              |
|---------------|--------------------------------------|
| Powerlevel10k | `p10k configure`                     |
| Aliases       | Add to `.zshrc`                      |
| Atuin         | `atuin register` then `atuin login`  |
| Bat fix       | `ln -s /usr/bin/batcat ~/.local/bin/bat` |

---

## 🐧 Final Notes

This development environment provides:
- Faster terminal workflows
- Modern CLI utilities
- Powerful command history search
- Fully synchronized VS Code setup
- Modular and reproducible configuration


## 📧 Contact

Feel free to reach out or contribute:

-   **LinkedIn:** Cesar Gonzalez
-   **GitHub:** ICaesarI
-   **Email:** cesar.gonzalez.anayadev@gmail.com# CaesarCode-Configuration-Script
