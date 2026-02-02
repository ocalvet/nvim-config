# Installation Guide

This guide explains how users can install this Neovim configuration.

## Automated Installation (Recommended)

The `install.sh` script provides full automation for Ubuntu/Debian and Arch-based Linux distributions.

**Supported distributions:**
- Ubuntu, Debian, Pop!_OS, Linux Mint
- Arch Linux, CachyOS, Manjaro, EndeavourOS, Garuda, Artix

### Quick Install

```bash
git clone <your-repo-url> /tmp/nvim-config
cd /tmp/nvim-config
./install.sh
```

This will:
1. Detect your OS (Ubuntu/Debian or Arch)
2. Install system dependencies (Node.js, Python, Rust, ripgrep, fd, etc.)
3. Install Neovim nightly via Bob (nvim version manager)
4. Install JetBrains Mono Nerd Font (desktop only)
5. Backup any existing `~/.config/nvim` configuration
6. Copy this configuration to `~/.config/nvim`
7. Install all plugins via lazy.nvim
8. Install LSP servers via Mason

### Installation Options

| Command | Description |
|---------|-------------|
| `./install.sh` | Full install (deps + config + plugins) |
| `./install.sh --deps-only` | Install dependencies only |
| `./install.sh --no-deps` | Install config only (skip dependencies) |
| `./install.sh --server` | Server mode (skip font, show instructions) |
| `./install.sh --help` | Show help message |

## What Gets Installed

### System Dependencies

**All Distributions:**
- Git, curl, wget, unzip
- Build tools (gcc, make, cmake)
- Node.js 18+ and npm
- Python 3.8+ and pip
- Rust/Cargo (via rustup)
- ripgrep (fast grep)
- fd (fast file finder)

**Ubuntu/Debian Specific:**
```bash
git curl wget unzip build-essential cmake nodejs npm \
python3 python3-pip python3-venv ripgrep fd-find
```

**Arch Linux Specific:**
```bash
git curl wget unzip base-devel cmake nodejs npm \
python python-pip ripgrep fd
```

### Neovim

- **Bob** - Neovim version manager (installed via Cargo)
- **Neovim nightly** - Latest development build
- Installed to: `~/.local/share/bob/nvim-bin/nvim`

### Fonts (Desktop Only)

- **JetBrains Mono Nerd Font** - For icons in Neovim
- Installed to: `~/.local/share/fonts/`
- Auto-configured with `fc-cache`

On servers (no GUI), instructions are shown for installing the font on your local terminal.

### Configuration

- Copied to: `~/.config/nvim`
- Existing config backed up to: `~/.config/nvim.bak.YYYYMMDD_HHMMSS`
- Plugins installed automatically via lazy.nvim
- LSP servers installed via Mason

### Shell Configuration

The script updates your `~/.bashrc` or `~/.zshrc` with:

```bash
# Rust/Cargo
source "$HOME/.cargo/env"

# Neovim (Bob)
export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"
```

## Server Installation

When running on a server (no GUI):

```bash
./install.sh --server
```

This skips font installation and shows instructions for installing the font on your local machine's terminal.

## Manual Installation

If you prefer to install manually or the script doesn't work for your system:

1. **Install system dependencies** (see above lists)

2. **Install Rust/Cargo:**
   ```bash
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
   source "$HOME/.cargo/env"
   ```

3. **Install Neovim nightly:**
   ```bash
   cargo install bob-nvim
   bob install nightly
   bob use nightly
   export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"
   ```

4. **Install Nerd Font** (desktop):
   ```bash
   mkdir -p ~/.local/share/fonts
   cd ~/.local/share/fonts
   curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
   unzip JetBrainsMono.zip && rm JetBrainsMono.zip
   fc-cache -fv
   ```

5. **Install configuration:**
   ```bash
   git clone <your-repo-url> ~/.config/nvim
   cd ~/.config/nvim
   ```

6. **Start Neovim:**
   ```bash
   nvim
   ```

   Plugins will install automatically on first launch.

## Post-Installation

### First Launch

1. **Restart your terminal:**
   ```bash
   source ~/.bashrc  # or ~/.zshrc
   ```

2. **Start Neovim:**
   ```bash
   nvim
   ```

3. **Wait for plugins to install** - This happens automatically

4. **Check health:**
   ```vim
   :checkhealth
   ```

### Verify Installation

Run these commands in Neovim:

```vim
:checkhealth              " Check all components
:Lazy                     " View installed plugins
:Mason                    " View installed LSP servers
:TSInstallInfo            " View treesitter parsers
```

### Install Additional Parsers

Treesitter parsers auto-install when you open files, but you can install manually:

```vim
:TSInstall python javascript typescript lua
```

### Install Additional LSP Servers

Open Mason and install servers:

```vim
:Mason
```

Press `i` to install, `X` to uninstall, `U` to update.

## Troubleshooting

### Script Fails on Dependency Installation

**Issue:** Package manager errors

**Solution:** Update package lists first:
```bash
# Ubuntu/Debian
sudo apt update

# Arch
sudo pacman -Syu
```

### Neovim Command Not Found

**Issue:** Bob path not in shell

**Solution:** Add to your shell config manually:
```bash
echo 'export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### Plugins Not Installing

**Issue:** Lazy.nvim errors on first launch

**Solution:**
```vim
:Lazy sync
:Lazy restore
```

### LSP Servers Not Working

**Issue:** Mason installation failed

**Solution:**
```vim
:Mason
# Press 'i' on the server to install
# Or run:
:MasonInstall lua-language-server pyright
```

### Icons Not Showing

**Issue:** Nerd Font not installed or terminal not configured

**Solution:**
1. Verify font is installed: `fc-list | grep -i "JetBrains"`
2. Set terminal font to "JetBrainsMono Nerd Font"
3. Restart terminal

### Permission Errors

**Issue:** Can't write to directories

**Solution:** Don't run the script with sudo. It will prompt for sudo only when needed.

## Updating the Configuration

### Pull Latest Changes

```bash
cd /path/to/config/repo
git pull
./install.sh --no-deps  # Copy updated config without reinstalling deps
```

### Update Plugins

```vim
:Lazy sync
:Lazy update
```

### Update LSP Servers

```vim
:Mason
# Press 'U' to update all
```

### Update Neovim

```bash
bob update nightly
```

## Uninstalling

### Remove Configuration

```bash
rm -rf ~/.config/nvim
```

### Remove Plugin Data

```bash
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim
```

### Remove Neovim

```bash
bob uninstall nightly
cargo uninstall bob-nvim
```

### Remove Dependencies

This depends on your package manager and what else you use them for. Generally not recommended unless you're sure nothing else needs them.

## Support

- Check [README.md](README.md) for quick reference
- See [USAGE.md](USAGE.md) for keybindings and usage
- Run `:checkhealth` in Neovim for diagnostics
