# Neovim Configuration

A modern Neovim configuration with LSP support, treesitter, and a clean interface.

## Prerequisites

- Neovim (v0.12+)
- git
- Language servers and formatters:
  - gopls (Go)
  - pyright-langserver (Python)
  - lua-language-server (Lua)
  - tsserver (TypeScript/JavaScript)
  - jsonls (JSON)
- Formatters:
  - gofmt (Go)
  - black (Python)
  - prettier (JavaScript/TypeScript/JSON/Markdown)
  - stylua (Lua)

## Installation

### 1. Install Neovim v0.12+

#### Ubuntu/Debian
```bash
# Add the neovim stable PPA
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update
sudo apt install neovim
```

#### Arch Linux
```bash
sudo pacman -S neovim
```

#### macOS
```bash
brew install neovim
```

#### From Source
```bash
git clone https://github.com/neovim/neovim
cd neovim
git checkout stable  # or a specific version tag like v0.12.0
make CMAKE_BUILD_TYPE=Release
sudo make install
```

### 2. Install Packer (Package Manager)

```bash
git clone --depth 1 https://github.com/wbthomason/packer.nvim \
  ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

### 3. Clone this repository

```bash
git clone https://github.com/ocalvet/nvim-config ~/.config/nvim
```

### 4. Install plugins

Open Neovim and run:

```
:PackerSync
```

This will install all the required plugins:
- telescope.nvim (fuzzy finder)
- catppuccin (color scheme)
- nvim-treesitter (syntax highlighting)
- undotree (undo history visualizer)
- vim-fugitive (Git integration)
- conform.nvim (formatting)

### 5. Install language servers and formatters

#### Go
```bash
go install golang.org/x/tools/gopls@latest
```

#### Python
```bash
pip install pyright black
```

#### TypeScript/JavaScript and Lua formatting
```bash
# Install TypeScript/JavaScript tools
npm install -g typescript typescript-language-server prettier

# Install stylua formatter for Lua
npm install -g @johnnymorganz/stylua-bin
```

#### Lua Language Server
```bash
# Install lua-language-server based on your OS
# For Ubuntu:
sudo apt install lua-language-server
# For Arch:
sudo pacman -S lua-language-server
# For macOS:
brew install lua-language-server
```

## Key Features

- Modern LSP-based completions and code navigation
- Treesitter for enhanced syntax highlighting
- Telescope for fuzzy finding files and text
- Git integration via vim-fugitive
- Code formatting via conform.nvim
- Catppuccin color scheme
- Simple and clean interface

## Key Mappings

- `<Space>` - Leader key
- `<leader>pv` - Open file explorer (netrw)
- `<leader>pf` - Find files with Telescope
- `<C-p>` - Find git files with Telescope
- `<leader>ps` - Grep search with Telescope
- `<leader>u` - Toggle UndoTree
- `<leader>gs` - Git status (fugitive)
- `<leader>f` - Format document (normal mode) or selection (visual mode)

### LSP Keybindings (available when LSP is active)

- `K` - Hover documentation
- `gd` - Go to definition
- `gD` - Go to declaration
- `gi` - Go to implementation
- `gr` - Find references
- `gs` - Signature help
- `<F2>` - Rename symbol
- `<F3>` - Format document
- `<F4>` - Code actions

## Customization

The configuration is modular and easy to extend:

- `lua/ovi/options.lua` - General Neovim options
- `lua/ovi/remap.lua` - Key mappings
- `lua/ovi/lsp.lua` - LSP configuration
- `lua/ovi/packer.lua` - Plugin management
- `lsp/` - Language server configurations
- `after/plugin/` - Plugin-specific configurations

## Troubleshooting

- Run `:checkhealth` to diagnose potential issues
- Ensure all language servers are properly installed and in your PATH
- Check `:messages` for any error logs
