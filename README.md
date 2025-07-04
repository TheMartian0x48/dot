# Dotfiles

> Documentation and organization enhanced with AI assistance

Personal development environment setup for macOS and Ubuntu/Debian.

## Quick Start

```bash
git clone https://github.com/yourusername/dot.git ~/.dotfiles
cd ~/.dotfiles
chmod +x setup.sh
./setup.sh
```

## What's Included

**Terminal & Shell:**
- Alacritty, Neovim, Tmux, Ranger
- Modern CLI tools: btop, fzf, ripgrep, bat, exa

**Development:**
- Git, Go, Python 3.11, Elixir
- Essential utilities: jq, curl, wget, tree

**System:**
- Window managers: Aerospace (macOS) / i3 (Ubuntu)
- Database: PostgreSQL, SQLite

## Features

- ✅ Cross-platform (macOS/Ubuntu)
- ✅ Automatic package installation
- ✅ Configuration symlinks to `~/.config`
- ✅ Safe backup of existing configs
- ✅ Idempotent (safe to run multiple times)

## Structure

```
dot/
├── setup.sh         # Main installation script
├── nvim/            # Neovim configuration
├── tmux/            # Tmux configuration
└── alacritty/       # Alacritty configuration
```

## Requirements

- **macOS:** Homebrew
- **Ubuntu/Debian:** apt package manager


> But sure to update details in .gitconfig
---

<sub>🤖 Documentation and repository organization enhanced with AI assistance</sub>