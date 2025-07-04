<div align="center">

# 🚀 Dotfiles

**Modern development environment for macOS & Linux**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/Platform-macOS%20%7C%20Linux-blue.svg)](https://github.com/yourusername/dot)
[![Shell](https://img.shields.io/badge/Shell-Zsh-green.svg)](https://www.zsh.org/)

*Documentation and organization enhanced with AI assistance* 🤖

---

</div>

## ✨ Features

- 🎯 **One-command setup** - Complete environment in minutes
- 🔄 **Cross-platform** - Works on macOS and Ubuntu/Debian
- 🛡️ **Safe & Reversible** - Backs up existing configs automatically
- 🔧 **Modern Tools** - Curated selection of productivity enhancers
- 📦 **Smart Dependencies** - Handles package managers automatically
- 🎨 **Beautiful Output** - Color-coded installation progress

## 🚀 Quick Start

```bash
# Clone the repository
git clone https://github.com/yourusername/dot.git ~/.dotfiles

# Navigate and run setup
cd ~/.dotfiles
chmod +x setup.sh
./setup.sh
```

> ⚠️ **Important:** Update your Git configuration after setup!
> ```bash
> git config --global user.email "your.email@example.com"
> git config --global user.name "Your Full Name"
> ```

## 📦 What's Included

### 🖥️ Terminal & Shell
| Tool | Purpose | macOS | Linux |
|------|---------|-------|-------|
| **Alacritty** | GPU-accelerated terminal | ✅ | ✅ |
| **Neovim** | Modern Vim editor | ✅ | ✅ |
| **Tmux** | Terminal multiplexer | ✅ | ✅ |
| **Zsh** | Advanced shell | ✅ | ✅ |

### 🔧 Modern CLI Tools
| Tool | Purpose | Replaces |
|------|---------|----------|
| **bat** | Syntax-highlighted cat | `cat` |
| **eza** | Modern file listing | `ls` |
| **fd** | Fast file finder | `find` |
| **ripgrep** | Ultra-fast grep | `grep` |
| **fzf** | Fuzzy finder | - |
| **zoxide** | Smart directory jumper | `cd` |
| **btop** | Resource monitor | `htop/top` |
| **dust** | Disk usage analyzer | `du` |
| **tldr** | Simplified man pages | `man` |

### 💻 Development Tools
- **Languages:** Go, Python 3.11, Elixir
- **Version Control:** Git with enhanced configuration
- **Data:** PostgreSQL, SQLite, jq
- **Network:** curl, wget
- **File Management:** ranger, tree

### 🪟 Window Management
- **macOS:** AeroSpace (tiling window manager)
- **Linux:** i3 (tiling window manager)

## 📁 Project Structure

```
dot/
├── 📄 setup.sh              # Main installation script
├── 📁 dot/                  # Dotfiles directory
│   ├── .gitconfig           # Git configuration
│   └── .zshrc              # Zsh configuration
├── 📁 alacritty/           # Terminal emulator config
├── 📁 nvim/                # Neovim configuration
├── 📁 tmux/                # Tmux configuration
├── 📁 btop/                # System monitor config
├── 📁 neofetch/            # System info config
└── 📄 README.md            # This file
```

## 🔧 Configuration Details

### Git Configuration Highlights
- **Enhanced aliases** - 40+ shortcuts for common operations
- **Delta pager** - Beautiful diff viewing
- **Auto-cleanup** - Removes merged branches automatically
- **Smart merging** - 3-way diff with conflict resolution
- **URL shortcuts** - `gh:user/repo` for GitHub clones

### Shell Enhancements
- **Smart completion** - Context-aware suggestions
- **History optimization** - Improved command history
- **Key bindings** - Efficient navigation shortcuts
- **Plugin ready** - Oh My Zsh compatible

## 🛠️ Requirements

### macOS
- **Homebrew** - Package manager for macOS
  ```bash
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```

### Ubuntu/Debian
- **apt** - Default package manager (pre-installed)
- **sudo access** - Required for package installation

## 🚀 Post-Installation

After running the setup script:

1. **Restart your terminal** or run:
   ```bash
   source ~/.zshrc
   ```

2. **Update Git configuration:**
   ```bash
   git config --global user.email "your.email@example.com"
   git config --global user.name "Your Full Name"
   ```

3. **Optional: Install additional tools**
   - Oh My Zsh plugins
   - Additional language runtimes
   - Custom themes

## 🎨 Customization

### Adding New Packages
Edit `setup.sh` and add your package:
```bash
install_package "macos_package" "linux_package" "[brew_flags]"
```

### Adding Configurations
1. Create your config directory
2. Add symlink in the setup script:
   ```bash
   create_symlink "$DOTFILES_DIR/your_config" "$CONFIG_DIR/your_config"
   ```

### Modifying Existing Configs
All configurations are symlinked, so edit files in the dotfiles directory:
```bash
cd ~/.dotfiles
nvim nvim/init.lua  # Edit Neovim config
```

## 🔍 Troubleshooting

### Common Issues

**Homebrew not found (macOS):**
```bash
# Install Homebrew first
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

**Permission denied:**
```bash
chmod +x setup.sh
```

**Existing application conflicts:**
The script automatically handles conflicts by:
- Backing up existing configs with timestamps
- Using `--force` flag for reinstallation when needed

**Git email still showing placeholder:**
```bash
# Check current config
git config --global --list

# Update manually
git config --global user.email "your.email@example.com"
```


## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Inspired by the dotfiles community
- Built with modern development practices
- Enhanced with AI assistance for documentation and organization

---

<div align="center">

**⭐ Star this repo if it helped you!**

*Made with ❤️ and ☕*

</div>