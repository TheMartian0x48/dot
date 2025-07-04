#!/bin/bash

OS=""

detect_os() {
    if [[ -z "$OS" ]]; then
        if [[ "$OSTYPE" == "darwin"* ]]; then
            OS="macos"
        elif [[ "$OSTYPE" == "linux-gnu"* ]] && command -v apt &> /dev/null; then
            OS="debian"
        else
            OS="unsupported"
        fi
    fi
    echo "$OS"
}

isMacOS() {
    [[ "$(detect_os)" == "macos" ]]
}

isDebian() {
    [[ "$(detect_os)" == "debian" ]]
}

install_macos_package() {
    local package="$1"
    local brew_flags="$2"
    
    if command -v "$package" &> /dev/null; then
        echo "$package is already installed"
        return 0
    fi
    
    echo "Installing $package on macOS..."
    if command -v brew &> /dev/null; then
        if [[ -n "$brew_flags" ]]; then
            brew install $brew_flags "$package"
        else
            brew install "$package"
        fi
    else
        echo "Error: Homebrew not found. Please install Homebrew first."
        return 1
    fi
    
    if command -v "$package" &> /dev/null; then
        echo "✅ $package installed successfully!"
        return 0
    else
        echo "❎ $package installation failed"
        return 1
    fi
}

install_debian_package() {
    local package="$1"
    
    if command -v "$package" &> /dev/null; then
        echo "$package is already installed"
        return 0
    fi
    
    echo "Installing $package on Ubuntu/Debian..."
    sudo apt update && sudo apt install -y "$package"
    
    if command -v "$package" &> /dev/null; then
        echo "✅ $package installed successfully!"
        return 0
    else
        echo "❎ $package installation failed"
        return 1
    fi
}

install_package() {
    local macos_package="$1"
    local linux_package="$2"
    local brew_flags="$3"
    
    if [[ -z "$macos_package" || -z "$linux_package" ]]; then
        echo "Error: Both macOS and Linux package names are required"
        echo "Usage: install_package <macos_package> <linux_package> [brew_flags]"
        return 1
    fi
    
    if isMacOS; then
        install_macos_package "$macos_package" "$brew_flags"
    elif isDebian; then
        install_debian_package "$linux_package"
    else
        echo "Error: This script only supports macOS and Ubuntu/Debian"
        return 1
    fi
}

echo "Starting package installation..."

install_package "alacritty" "alacritty" "--cask"
install_package "nvim" "neovim"
install_package "btop" "btop"
install_package "ranger" "ranger"
install_package "neofetch" "neofetch"
install_package "tmux" "tmux"
install_package "git" "git"
install_package "go" "golang-go"
install_package "fzf" "fzf"   
install_package "ripgrep" "ripgrep"
install_package "fd" "fd-find"     
install_package "bat" "bat"      # cat replacement
install_package "tree" "tree"
install_package "jq" "jq"  
install_package "curl" "curl"
install_package "wget" "wget"
install_package "eza" "eza" # ls replacement
install_package "sqlite" "sqlite3"
install_package "postgresql" "postgresql"
install_package "python@3.11" "python3.11"
install_package "bpython" "bpython"
install_package "elixir" "elixir"
install_package "dust" "dust" 

if isMacOS; then
    install_macos_package "aerospace" "--cask"
elif isDebian; then
    install_debian_package "i3"
fi

echo "Creating configuration symlinks..."

CONFIG_DIR="$HOME/.config"
DOTFILES_DIR="$(dirname "$(realpath "$0")")"

mkdir -p "$CONFIG_DIR"

create_symlink() {
    local source="$1"
    local target="$2"
    
    if [[ -e "$target" ]]; then
        if [[ -L "$target" ]]; then
            echo "Symlink already exists: $target"
        else
            echo "File/directory exists, backing up: $target"
            mv "$target" "${target}.backup.$(date +%Y%m%d_%H%M%S)"
            ln -sf "$source" "$target"
            echo "✅ Created symlink: $target -> $source"
        fi
    else
        ln -sf "$source" "$target"
        echo "✅ Created symlink: $target -> $source"
    fi
}

if [[ -d "$DOTFILES_DIR/alacritty" ]]; then
    create_symlink "$DOTFILES_DIR/alacritty" "$CONFIG_DIR/alacritty"
fi

if [[ -d "$DOTFILES_DIR/nvim" ]]; then
    create_symlink "$DOTFILES_DIR/nvim" "$CONFIG_DIR/nvim"
fi

if [[ -d "$DOTFILES_DIR/tmux" ]]; then
    create_symlink "$DOTFILES_DIR/tmux" "$CONFIG_DIR/tmux"
fi

if [[ -f "$DOTFILES_DIR/.zshrc" ]]; then
    create_symlink "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
fi

if [[ -f "$DOTFILES_DIR/.gitconfig" ]]; then
    create_symlink "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
fi

echo "✅ All packages installation completed!"
