#!/usr/bin/env bash
#
# Neovim Configuration Installer
# Supports: Ubuntu/Debian, Arch Linux
#
# Usage:
#   ./install.sh              Full install (deps + config + plugins)
#   ./install.sh --deps-only  Install system dependencies only
#   ./install.sh --no-deps    Install config only (skip system deps)
#   ./install.sh --server     Server mode (skip font install)
#   ./install.sh --help       Show help

set -e

# ============== Configuration ==============
NVIM_CONFIG_DIR="$HOME/.config/nvim"
FONT_DIR="$HOME/.local/share/fonts"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ============== Color Output ==============
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

info()    { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[✓]${NC} $1"; }
warn()    { echo -e "${YELLOW}[!]${NC} $1"; }
error()   { echo -e "${RED}[✗]${NC} $1"; exit 1; }

# ============== Help ==============
show_help() {
    cat << 'EOF'
Neovim Configuration Installer

Usage:
  ./install.sh [OPTIONS]

Options:
  --deps-only    Install system dependencies only
  --no-deps      Install config only (skip system dependencies)
  --server       Server mode (skip font, show instructions)
  --help         Show this help message

Examples:
  ./install.sh              # Full install
  ./install.sh --deps-only  # Just install dependencies
  ./install.sh --server     # Install on a server (no GUI)

EOF
}

# ============== OS Detection ==============
detect_os() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        case "$ID" in
            ubuntu|debian|pop|linuxmint) OS="debian" ;;
            arch|manjaro|endeavouros|cachyos|garuda|artix) OS="arch" ;;
            *) error "Unsupported OS: $ID. Only Ubuntu/Debian and Arch-based distributions are supported." ;;
        esac
    else
        error "Cannot detect OS. /etc/os-release not found."
    fi
    info "Detected OS: $OS ($PRETTY_NAME)"
}

# ============== Detect Environment ==============
detect_environment() {
    if [ -z "$DISPLAY" ] && [ -z "$WAYLAND_DISPLAY" ]; then
        IS_SERVER=true
        info "Server environment detected (no GUI)"
    else
        IS_SERVER=false
        info "Desktop environment detected"
    fi
}

# ============== Install System Dependencies ==============
install_deps_debian() {
    info "Installing system dependencies..."
    sudo apt install -y \
        git curl wget unzip \
        build-essential cmake \
        nodejs npm \
        python3 python3-pip python3-venv \
        ripgrep fd-find

    success "System dependencies installed"
}

install_deps_arch() {
    info "Installing system dependencies..."
    sudo pacman -S --noconfirm --needed \
        git curl wget unzip \
        base-devel cmake \
        nodejs npm \
        python python-pip \
        ripgrep fd

    success "System dependencies installed"
}

# ============== Install Rust/Cargo ==============
install_rust() {
    if command -v cargo &> /dev/null; then
        success "Cargo already installed ($(cargo --version))"
        return 0
    fi

    info "Installing Rust/Cargo..."
    
    # Try system package manager first (faster than rustup)
    if [[ "$OS_TYPE" == "arch" ]]; then
        info "Attempting to install from system packages..."
        if sudo pacman -S --noconfirm rust 2>/dev/null; then
            success "Rust installed from system packages"
            if command -v cargo &> /dev/null; then
                success "Cargo installed ($(cargo --version))"
                return 0
            fi
        fi
    elif [[ "$OS_TYPE" == "debian" ]]; then
        info "Attempting to install from system packages..."
        if sudo apt-get install -y cargo 2>/dev/null; then
            success "Cargo installed from system packages"
            if command -v cargo &> /dev/null; then
                success "Cargo installed ($(cargo --version))"
                return 0
            fi
        fi
    fi

    # Fall back to rustup if system packages failed or unavailable
    info "Installing via rustup..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

    # Source cargo environment
    if [ -f "$HOME/.cargo/env" ]; then
        source "$HOME/.cargo/env"
    fi

    if command -v cargo &> /dev/null; then
        success "Cargo installed ($(cargo --version))"
    else
        error "Failed to install Cargo. Please install manually."
    fi
}

# ============== Install Neovim ==============
install_neovim() {
    # Check if nvim is already installed with sufficient version
    if command -v nvim &> /dev/null; then
        local version=$(nvim --version | head -1)
        if [[ "$version" == *"0.10"* ]] || [[ "$version" == *"0.11"* ]] || [[ "$version" == *"0.12"* ]]; then
            success "Neovim already installed ($version)"
            return 0
        fi
    fi

    info "Installing Bob (Neovim version manager)..."
    cargo install bob-nvim

    info "Installing Neovim stable via Bob..."
    "$HOME/.cargo/bin/bob" install stable
    "$HOME/.cargo/bin/bob" use stable

    # Add bob to PATH for this session
    export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"

    if command -v nvim &> /dev/null; then
        success "Neovim stable installed: $(nvim --version | head -1)"
    else
        error "Failed to install Neovim. Check that Bob installed correctly."
    fi
}

# ============== Switch to Neovim Nightly (Optional) ==============
switch_to_nightly() {
    warn "You're using Neovim dev build. This may cause treesitter compatibility issues."
    info "To switch to stable: bob use stable"
    info "To update nightly: bob update nightly"
}

# ============== Install Nerd Font ==============
install_font() {
    if [ "$IS_SERVER" = true ] || [ "$SERVER_MODE" = true ]; then
        show_font_instructions
        return 0
    fi

    info "Installing JetBrains Mono Nerd Font..."
    mkdir -p "$FONT_DIR"

    local temp_dir=$(mktemp -d)
    cd "$temp_dir"

    curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
    unzip -o JetBrainsMono.zip -d "$FONT_DIR"
    rm JetBrainsMono.zip

    # Refresh font cache
    fc-cache -fv > /dev/null 2>&1

    success "JetBrains Mono Nerd Font installed to $FONT_DIR"
    info "Set your terminal font to 'JetBrainsMono Nerd Font' to see icons"
}

show_font_instructions() {
    cat << 'EOF'

════════════════════════════════════════════════════════════
  Nerd Font Installation (required for icons)
════════════════════════════════════════════════════════════

Your LOCAL terminal needs a Nerd Font. Download from:
  https://github.com/ryanoasis/nerd-fonts/releases/latest

Install on your local machine:

  macOS:
    brew install --cask font-jetbrains-mono-nerd-font

  Windows:
    choco install nerd-fonts-jetbrainsmono
    # Or download and install manually from the link above

  Linux Desktop:
    mkdir -p ~/.local/share/fonts
    cd ~/.local/share/fonts
    curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
    unzip JetBrainsMono.zip && rm JetBrainsMono.zip
    fc-cache -fv

Then set your terminal font to "JetBrainsMono Nerd Font".
════════════════════════════════════════════════════════════

EOF
}

# ============== Backup Existing Config ==============
backup_config() {
    if [ -d "$NVIM_CONFIG_DIR" ]; then
        BACKUP_DIR="${NVIM_CONFIG_DIR}.bak.$(date +%Y%m%d_%H%M%S)"
        warn "Existing config found at $NVIM_CONFIG_DIR"
        info "Backing up to $BACKUP_DIR"
        mv "$NVIM_CONFIG_DIR" "$BACKUP_DIR"
        success "Backup created"
    fi
}

# ============== Install Config ==============
install_config() {
    info "Installing Neovim configuration..."

    # Create parent directory if needed
    mkdir -p "$(dirname "$NVIM_CONFIG_DIR")"

    # Copy config to ~/.config/nvim
    cp -r "$SCRIPT_DIR" "$NVIM_CONFIG_DIR"

    # Remove install script and git from copied config
    rm -f "$NVIM_CONFIG_DIR/install.sh"
    rm -rf "$NVIM_CONFIG_DIR/.git"

    success "Config copied to $NVIM_CONFIG_DIR"
}

# ============== Initialize Neovim ==============
init_neovim() {
    info "Installing plugins (this may take a minute)..."
    nvim --headless "+Lazy! sync" +qa 2>/dev/null || true

    info "Installing LSP servers..."
    nvim --headless "+MasonInstall lua-language-server pyright typescript-language-server" +qa 2>/dev/null || true

    success "Neovim initialized with plugins and LSP servers"
}

# ============== Update Shell Config ==============
update_shell_config() {
    local shell_rc=""

    case "$SHELL" in
        */bash) shell_rc="$HOME/.bashrc" ;;
        */zsh)  shell_rc="$HOME/.zshrc" ;;
        *)
            warn "Unknown shell ($SHELL). Skipping PATH updates."
            warn "Add these to your shell config manually:"
            echo '  export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"'
            echo '  source "$HOME/.cargo/env"'
            return
            ;;
    esac

    local updated=false

    # Add cargo to PATH (only if installed via rustup)
    if [ -f "$HOME/.cargo/env" ] && ! grep -q 'cargo/env' "$shell_rc" 2>/dev/null; then
        echo '' >> "$shell_rc"
        echo '# Rust/Cargo (rustup)' >> "$shell_rc"
        echo '[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"' >> "$shell_rc"
        updated=true
    fi

    # Add cargo bin to PATH (for both rustup and system installations)
    if [ -d "$HOME/.cargo/bin" ] && ! grep -q '.cargo/bin' "$shell_rc" 2>/dev/null; then
        echo '' >> "$shell_rc"
        echo '# Cargo binaries' >> "$shell_rc"
        echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> "$shell_rc"
        updated=true
    fi

    # Add bob nvim to PATH
    if ! grep -q 'bob/nvim-bin' "$shell_rc" 2>/dev/null; then
        echo '' >> "$shell_rc"
        echo '# Neovim (Bob)' >> "$shell_rc"
        echo 'export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"' >> "$shell_rc"
        updated=true
    fi

    if [ "$updated" = true ]; then
        success "Updated $shell_rc with PATH entries"
    fi
}

# ============== Main ==============
main() {
    echo ""
    echo "╔═══════════════════════════════════════════╗"
    echo "║     Neovim Configuration Installer        ║"
    echo "╚═══════════════════════════════════════════╝"
    echo ""

    # Parse arguments
    DEPS_ONLY=false
    NO_DEPS=false
    SERVER_MODE=false

    for arg in "$@"; do
        case $arg in
            --deps-only) DEPS_ONLY=true ;;
            --no-deps)   NO_DEPS=true ;;
            --server)    SERVER_MODE=true ;;
            --help)      show_help; exit 0 ;;
            *)           warn "Unknown option: $arg" ;;
        esac
    done

    if [ "$DEPS_ONLY" = true ] && [ "$NO_DEPS" = true ]; then
        error "Cannot use --deps-only and --no-deps together"
    fi

    detect_os
    detect_environment

    # Install dependencies
    if [ "$NO_DEPS" = false ]; then
        info "Installing system dependencies..."

        case "$OS" in
            debian) install_deps_debian ;;
            arch)   install_deps_arch ;;
        esac

        install_rust

        # Source cargo for this session
        if [ -f "$HOME/.cargo/env" ]; then
            source "$HOME/.cargo/env"
        fi

        install_neovim
        install_font
        update_shell_config
    fi

    # If only installing deps, exit now
    if [ "$DEPS_ONLY" = true ]; then
        echo ""
        success "Dependencies installed!"
        echo ""
        echo "Next steps:"
        echo "  1. Restart your terminal (or run: source ~/.bashrc)"
        echo "  2. Clone/copy this config to ~/.config/nvim"
        echo "  3. Run: nvim"
        echo ""
        exit 0
    fi

    # Install config
    backup_config
    install_config
    init_neovim

    echo ""
    echo "╔═══════════════════════════════════════════╗"
    echo "║        Installation Complete! 🎉          ║"
    echo "╚═══════════════════════════════════════════╝"
    echo ""
    echo "Next steps:"
    echo "  1. Restart your terminal (or run: source ~/.bashrc)"
    echo "  2. Run: nvim"
    echo "  3. Wait for any remaining plugins to install"
    echo ""
    echo "Verify setup with: nvim -c ':checkhealth'"
    echo ""
    echo "Documentation:"
    echo "  • Keybindings: $NVIM_CONFIG_DIR/USAGE.md"
    echo "  • Quick help: Press <Space> in Neovim (leader key)"
    echo ""
}

main "$@"
