# Neovim Configuration

A modern Neovim configuration with LSP, fuzzy finding, Git integration, debugging, and testing support.

## Quick Install

### Ubuntu/Debian & Arch-based Linux

```bash
git clone <your-repo-url> /tmp/nvim-config
cd /tmp/nvim-config
./install.sh
```

**Supported distributions:**
- Ubuntu, Debian, Pop!_OS, Linux Mint
- Arch Linux, CachyOS, Manjaro, EndeavourOS, Garuda, Artix

The install script will:
- Install all system dependencies (Node.js, Python, Rust, ripgrep, fd, etc.)
- Install Neovim stable via Bob (switch to nightly with `bob use nightly` if desired)
- Install JetBrains Mono Nerd Font (desktop only)
- Copy the configuration to `~/.config/nvim`
- Install all plugins and LSP servers automatically

### Installation Options

```bash
./install.sh              # Full install (recommended)
./install.sh --deps-only  # Install dependencies only
./install.sh --no-deps    # Install config only (if deps already installed)
./install.sh --server     # Server mode (skip font, show install instructions)
./install.sh --help       # Show all options
```

## Manual Installation

### Requirements

- **Neovim 0.10+** (stable or nightly)
  - **Note:** Dev builds (0.11+, 0.12+) may have treesitter compatibility issues
  - The config auto-disables problematic features on dev builds
- **Node.js 18+** and npm
- **Python 3.8+** and pip
- **Rust/Cargo** (for installing Bob and other tools)
- **ripgrep** - Fast grep for live search
- **fd** - Fast file finder
- **Nerd Font** - For icons (JetBrains Mono recommended)

### Manual Setup Steps

1. **Install dependencies** for your OS (see below)

2. **Clone configuration:**
   ```bash
   git clone <your-repo-url> ~/.config/nvim
   cd ~/.config/nvim
   ```

3. **Start Neovim:**
   ```bash
   nvim
   ```

4. Plugins and LSP servers install automatically on first launch

### System Dependencies by OS

<details>
<summary>Ubuntu/Debian</summary>

```bash
# System packages
sudo apt update
sudo apt install -y git curl wget unzip build-essential cmake \
  nodejs npm python3 python3-pip python3-venv ripgrep fd-find

# Rust/Cargo
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"

# Neovim nightly (via Bob)
cargo install bob-nvim
bob install nightly
bob use nightly
```
</details>

<details>
<summary>Arch Linux</summary>

```bash
# System packages
sudo pacman -Syu
sudo pacman -S git curl wget unzip base-devel cmake \
  nodejs npm python python-pip ripgrep fd

# Rust/Cargo
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"

# Neovim nightly (via Bob)
cargo install bob-nvim
bob install nightly
bob use nightly
```
</details>

## Features

### Core Features

- **LSP Support** - Language servers with Mason auto-installation
- **Fuzzy Finding** - Telescope for files, grep, and navigation
- **Syntax Highlighting** - Treesitter with auto-install on file open
- **Autocompletion** - nvim-cmp with snippets and LSP integration
- **Auto-formatting** - Format on save with none-ls

### Development Tools

- **Git Integration** - Gitsigns, Neogit, and Diffview
- **Debugging** - DAP for Python, JavaScript/TypeScript, and Go
- **Testing** - Neotest for pytest, jest, and go test
- **File Explorer** - Neo-tree with Git status

### Language Support

Out-of-the-box LSP and tooling for:
- **Lua** - lua_ls with Neovim API support
- **Python** - pyright + ruff
- **JavaScript/TypeScript** - ts_ls + prettier + eslint
- **Go** - gopls
- **Web** - HTML, CSS, Tailwind CSS
- **DevOps** - Docker, Terraform, YAML, JSON, SQL

## Documentation

- **[USAGE.md](USAGE.md)** - Complete keybindings and usage guide
- **[AGENTS.md](AGENTS.md)** - Guidelines for AI coding agents

## Quick Reference

### Leader Key

The leader key is `<Space>`. Most custom keybindings start with it.

### Essential Keybindings

| Key | Action |
|-----|--------|
| `<leader>sf` | Find files |
| `<leader>sg` | Live grep (search in files) |
| `<leader>e` | Toggle file explorer |
| `<leader>gg` | Git status (Neogit) |
| `gd` | Go to definition |
| `<leader>ca` | Code action |
| `<leader>rn` | Rename symbol |
| `<leader>tr` | Run nearest test |
| `<F5>` | Start debugging |

Press `<Space>` in Neovim to see all available keybindings (via which-key).

## Customization

### Adding Plugins

Create a new file in `lua/plugins/`:

```lua
-- lua/plugins/my-plugin.lua
return {
  "author/plugin-name",
  config = function()
    require("plugin-name").setup({})
  end,
}
```

Then restart Neovim. Lazy.nvim will auto-detect and install it.

### Adding LSP Servers

Edit `lua/plugins/lsp.lua` and add to the `ensure_installed` list:

```lua
ensure_installed = {
  "ts_ls", "pyright", "rust_analyzer",  -- Add your server
},
```

Then add configuration in the `servers` table:

```lua
servers = {
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = { command = "clippy" },
      },
    },
  },
}
```

## Troubleshooting

### Check Health

```vim
:checkhealth              " Check all components
:checkhealth mason        " Check LSP servers
:checkhealth treesitter   " Check parsers
```

### Common Issues

**Plugins not loading:**
```vim
:Lazy sync                " Reinstall all plugins
```

**LSP not working:**
```vim
:Mason                    " Open Mason to install servers
:LspInfo                  " Check LSP status
:LspRestart               " Restart LSP
```

**Treesitter errors:**
```vim
:TSInstall lua vim python " Install specific parsers
:TSUpdate                 " Update all parsers
```

**Icons not showing:**
- Install a Nerd Font (JetBrains Mono recommended)
- Set your terminal font to "JetBrainsMono Nerd Font"

### Reset Everything

```bash
# Remove all Neovim data
rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim

# Restart Neovim (plugins will reinstall)
nvim
```

## Contributing

Issues and pull requests welcome!

## License

MIT
