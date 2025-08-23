#!/bin/bash

# Color codes for beautiful output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Enhanced logging functions with padding
log_info() {
    echo -e "  ${BLUE}ℹ️  ${NC}$1"
}

log_success() {
    echo -e "  ${GREEN}✅ ${NC}$1"
}

log_warning() {
    echo -e "  ${YELLOW}⚠️  ${NC}$1"
}

log_error() {
    echo -e "  ${RED}❌ ${NC}$1"
}

log_header() {
    echo -e "\n  ${BOLD}${PURPLE}$1${NC}"
    echo -e "  ${PURPLE}$(printf '=%.0s' {1..50})${NC}"
}

log_step() {
    echo -e "  ${CYAN}🔧 ${NC}$1"
}

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
    
    # Check if it's a cask and already installed via brew
    if [[ "$brew_flags" == *"--cask"* ]] && brew list --cask "$package" &> /dev/null; then
        log_info "$package is already installed ${CYAN}(cask)${NC}"
        return 0
    elif [[ "$brew_flags" != *"--cask"* ]] && command -v "$package" &> /dev/null; then
        log_info "$package is already installed"
        return 0
    fi
    
    log_step "Installing $package on macOS..."
    if command -v brew &> /dev/null; then
        if [[ -n "$brew_flags" ]]; then
            # Try regular install first
            if ! brew install $brew_flags "$package" 2>/dev/null; then
                # If it fails due to existing app, try with --force
                if [[ "$brew_flags" == *"--cask"* ]]; then
                    log_warning "Attempting to reinstall $package with --force..."
                    brew install --cask "$package" --force
                fi
            fi
        else
            brew install "$package"
        fi
    else
        log_error "Homebrew not found. Please install Homebrew first."
        return 1
    fi
    
    log_success "$package installation completed!"
    return 0
}

install_debian_package() {
    local package="$1"
    
    if command -v "$package" &> /dev/null; then
        log_info "$package is already installed"
        return 0
    fi
    
    log_step "Installing $package on Ubuntu/Debian..."
    sudo apt update -qq && sudo apt install -y "$package"
    
    if command -v "$package" &> /dev/null; then
        log_success "$package installed successfully!"
        return 0
    else
        log_error "$package installation failed"
        return 1
    fi
}

install_package() {
    local macos_package="$1"
    local linux_package="$2"
    local brew_flags="$3"
    
    if [[ -z "$macos_package" || -z "$linux_package" ]]; then
        log_error "Both macOS and Linux package names are required"
        echo "  Usage: install_package <macos_package> <linux_package> [brew_flags]"
        return 1
    fi
    
    if isMacOS; then
        install_macos_package "$macos_package" "$brew_flags"
    elif isDebian; then
        install_debian_package "$linux_package"
    else
        log_error "This script only supports macOS and Ubuntu/Debian"
        return 1
    fi
}

# Beautiful header
clear
echo -e "  ${BOLD}${PURPLE}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "  ${BOLD}${PURPLE}║                    🚀 DOTFILES SETUP SCRIPT                  ║${NC}"
echo -e "  ${BOLD}${PURPLE}║                      Welcome to the setup!                   ║${NC}"
echo -e "  ${BOLD}${PURPLE}╚══════════════════════════════════════════════════════════════╝${NC}"
echo ""

# OS Detection
log_header "🔍 SYSTEM DETECTION"
OS_NAME=$(detect_os)
case "$OS_NAME" in
    "macos")
        log_success "Detected: 🍎 macOS $(sw_vers -productVersion)"
        ;;
    "debian")
        log_success "Detected: 🐧 $(lsb_release -d | cut -f2)"
        ;;
    *)
        log_error "Unsupported operating system"
        exit 1
        ;;
esac

log_header "📦 PACKAGE INSTALLATION"

# Terminal & Shell Tools
echo -e "  ${CYAN}📱 Installing terminal applications...${NC}"
install_package "alacritty" "alacritty" "--cask"
install_package "tmux" "tmux"
install_package "nushell" "nushell"

# Editors & Development
echo -e "  ${CYAN}⚡ Installing development tools...${NC}"
install_package "nvim" "neovim"
install_package "git" "git"
install_package "go" "golang-go"

# System Utilities
echo -e "  ${CYAN}🖥️  Installing system utilities...${NC}"
install_package "btop" "btop"
install_package "ranger" "ranger"
install_package "neofetch" "neofetch"

# Search & Navigation
echo -e "  ${CYAN}🔍 Installing search and navigation tools...${NC}"
install_package "fzf" "fzf"   
install_package "ripgrep" "ripgrep"
install_package "fd" "fd-find"     
install_package "zoxide" "zoxide"

# File Management
echo -e "  ${CYAN}📁 Installing file management tools...${NC}"
install_package "bat" "bat"      # cat replacement
install_package "tree" "tree"
install_package "eza" "eza"      # ls replacement
install_package "dust" "dust"

# Network & Data
echo -e "  ${CYAN}🌐 Installing network and data tools...${NC}"
install_package "jq" "jq"  
install_package "curl" "curl"
install_package "wget" "wget"
install_package "tldr" "tldr"

# Databases
echo -e "  ${CYAN}🗄️  Installing database tools...${NC}"
install_package "sqlite" "sqlite3"
install_package "postgresql" "postgresql"

# Programming Languages
echo -e "  ${CYAN}💻 Installing programming languages...${NC}"
install_package "python@3.11" "python3.11"
install_package "bpython" "bpython"
install_package "elixir" "elixir"

# Window Management
echo -e "  ${CYAN}🪟 Installing window management...${NC}"
if isMacOS; then
    install_macos_package "aerospace" "--cask"
elif isDebian; then
    install_debian_package "i3"
fi

log_header "🔗 CONFIGURATION SYMLINKS"

CONFIG_DIR="$HOME/.config"
DOTFILES_DIR="$(dirname "$(realpath "$0")")"

mkdir -p "$CONFIG_DIR"

create_symlink() {
    local source="$1"
    local target="$2"
    
    if [[ -e "$target" ]]; then
        if [[ -L "$target" ]]; then
            log_info "Symlink already exists: ${CYAN}$(basename "$target")${NC}"
        else
            log_warning "File/directory exists, backing up: $(basename "$target")"
            mv "$target" "${target}.backup.$(date +%Y%m%d_%H%M%S)"
            ln -sf "$source" "$target"
            log_success "Created symlink: ${CYAN}$(basename "$target")${NC} → ${YELLOW}$(basename "$source")${NC}"
        fi
    else
        ln -sf "$source" "$target"
        log_success "Created symlink: ${CYAN}$(basename "$target")${NC} → ${YELLOW}$(basename "$source")${NC}"
    fi
}

# Configuration symlinks
configs=(
    "alacritty:$CONFIG_DIR/alacritty"
    "nvim:$CONFIG_DIR/nvim"
    "tmux:$CONFIG_DIR/tmux"
    "btop:$CONFIG_DIR/btop"
    "neofetch:$CONFIG_DIR/neofetch"
    "nu:$CONFIG_DIR/nushell"
)

for config in "${configs[@]}"; do
    IFS=':' read -r dir target <<< "$config"
    if [[ -d "$DOTFILES_DIR/$dir" ]]; then
        create_symlink "$DOTFILES_DIR/$dir" "$target"
    fi
done

# Dotfiles symlinks
if [[ -f "$DOTFILES_DIR/dot/.zshrc" ]]; then
    create_symlink "$DOTFILES_DIR/dot/.zshrc" "$HOME/.zshrc"
fi

if [[ -f "$DOTFILES_DIR/dot/.gitconfig" ]]; then
    create_symlink "$DOTFILES_DIR/dot/.gitconfig" "$HOME/.gitconfig"
fi

post_install_setup() {
    log_header "⚙️  POST-INSTALLATION SETUP"
    
    # Setup Nushell configuration
    log_step "Setting up Nushell configuration..."
    mkdir -p "$HOME/Library/Application Support/nushell"
    ln -sf "$DOTFILES_DIR/nushell/config.nu" "$HOME/Library/Application Support/nushell/config.nu"
    ln -sf "$DOTFILES_DIR/nushell/env.nu" "$HOME/Library/Application Support/nushell/env.nu"
    
    # Update Ghostty config for Nushell
    if [[ -f "$CONFIG_DIR/ghostty/config" ]]; then
        log_step "Configuring Ghostty to use Nushell..."
        if ! grep -q "command = \"/opt/homebrew/bin/nu --config" "$CONFIG_DIR/ghostty/config"; then
            # Check if command line already exists and update it
            if grep -q "command = " "$CONFIG_DIR/ghostty/config"; then
                sed -i '' 's|command = .*|command = "/opt/homebrew/bin/nu --config '$DOTFILES_DIR'/nushell/config.nu --env-config '$DOTFILES_DIR'/nushell/env.nu"|g' "$CONFIG_DIR/ghostty/config"
            else
                # Add command line if it doesn't exist
                echo 'command = "/opt/homebrew/bin/nu --config '$DOTFILES_DIR'/nushell/config.nu --env-config '$DOTFILES_DIR'/nushell/env.nu"' >> "$CONFIG_DIR/ghostty/config"
            fi
            log_success "Ghostty configured to use Nushell with custom config paths"
        else
            log_info "Ghostty already configured for Nushell"
        fi
    fi
    
    log_success "Nushell configuration completed"
    
    # Setup zoxide
    if command -v zoxide &> /dev/null; then
        log_step "Setting up zoxide..."
        if ! grep -q "zoxide init" "$HOME/.zshrc" 2>/dev/null; then
            echo 'eval "$(zoxide init zsh)"' >> "$HOME/.zshrc"
            log_success "Added zoxide initialization to .zshrc"
        else
            log_info "zoxide already configured in .zshrc"
        fi
    fi
    
    # Setup fzf key bindings
    if command -v fzf &> /dev/null; then
        log_step "Setting up fzf key bindings..."
        if isMacOS; then
            if [[ -f "$(brew --prefix)/opt/fzf/install" ]]; then
                $(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc --no-bash --no-fish
                log_success "fzf key bindings installed"
            fi
        elif isDebian; then
            if [[ -f "/usr/share/doc/fzf/examples/key-bindings.zsh" ]]; then
                if ! grep -q "key-bindings.zsh" "$HOME/.zshrc" 2>/dev/null; then
                    echo 'source /usr/share/doc/fzf/examples/key-bindings.zsh' >> "$HOME/.zshrc"
                    echo 'source /usr/share/doc/fzf/examples/completion.zsh' >> "$HOME/.zshrc"
                    log_success "fzf key bindings added to .zshrc"
                fi
            fi
        fi
    fi
    
    # Setup Nushell configuration
    if command -v nu &> /dev/null; then
        log_step "Setting up Nushell..."
        mkdir -p "$HOME/.config/nushell"
        log_success "Nushell configuration is ready to use"
    fi
    
    echo ""
    echo -e "  ${BOLD}${RED}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "  ${BOLD}${RED}║                    ⚠️  IMPORTANT NOTICE                      ║${NC}"
    echo -e "  ${BOLD}${RED}║                 Please update your Git config!              ║${NC}"
    echo -e "  ${BOLD}${RED}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "  ${YELLOW}📧 Update your email in ~/.gitconfig:${NC}"
    echo -e "     ${RED}Current: a@a${NC}"
    echo -e "     ${GREEN}Change to your actual email address${NC}"
    echo ""
    echo -e "  ${CYAN}🔧 You can update it by running:${NC}"
    echo -e "     ${WHITE}git config --global user.email 'your.email@example.com'${NC}"
    echo -e "     ${WHITE}git config --global user.name 'Your Full Name'${NC}"
    echo ""
    echo -e "  ${PURPLE}📝 Or manually edit ~/.gitconfig file${NC}"
    echo ""
    
    echo -e "  ${BOLD}${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "  ${BOLD}${GREEN}║                       🎉 SETUP COMPLETE!                     ║${NC}"
    echo -e "  ${BOLD}${GREEN}║                   Your dotfiles are ready!                  ║${NC}"
    echo -e "  ${BOLD}${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "  ${CYAN}🔄 Please restart your terminal or run:${NC}"
    echo -e "     ${WHITE}source ~/.zshrc${NC}"
    echo ""
}

log_success "All packages installation completed!"
post_install_setup
