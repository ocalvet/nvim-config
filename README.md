# Neovim Configuration

A modern Neovim configuration with LSP support, fuzzy finding, and comprehensive development tools.

## Features

- **LSP Support**: Language Server Protocol with Mason for automatic installation
- **Fuzzy Finding**: Telescope for file searching and navigation
- **Syntax Highlighting**: Treesitter for enhanced syntax highlighting
- **File Explorer**: Neo-tree for project navigation
- **Git Integration**: Gitsigns for Git status and operations
- **Autocompletion**: nvim-cmp with LuaSnip for code completion
- **Auto-formatting**: Automatic code formatting
- **Modern UI**: Lualine status line and Bufferline tabs
- **Nord Theme**: Beautiful Nord color scheme

## Requirements

- Neovim 0.8+
- Git
- Node.js and npm (for some LSP servers)
- `make` (for telescope-fzf-native)
- A Nerd Font (for icons)

## Installation

1. Backup your existing Neovim configuration:
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. Clone this configuration:
   ```bash
   git clone <repository-url> ~/.config/nvim
   ```

3. Start Neovim:
   ```bash
   nvim
   ```

4. The configuration will automatically install plugins and LSP servers on first launch.

## Key Bindings

### General
- `<Space>` - Leader key
- `<C-s>` - Save file
- `<leader>sn` - Save file without formatting
- `x` - Delete character without copying to register

### Navigation
- `<C-d>` / `<C-u>` - Scroll down/up and center
- `n` / `N` - Find next/previous and center
- `<C-h/j/k/l>` - Navigate splits

### Buffers
- `<Tab>` - Next buffer
- `<S-Tab>` - Previous buffer
- `<leader>x` - Close buffer
- `<leader>b` - New buffer

### Window Management
- `<leader>v` - Vertical split
- `<leader>h` - Horizontal split
- `<leader>se` - Equal splits
- `<leader>xs` - Close split

### File Explorer (Neo-tree)
- `<leader>e` - Toggle file explorer
- `\\` - Reveal current file in explorer
- `<leader>ngs` - Open Git status window

### Telescope (Fuzzy Finding)
- `<leader>sf` - Search files
- `<leader>sg` - Live grep
- `<leader>sb` - Search buffers
- `<leader>sh` - Search help
- `<leader>sw` - Search current word
- `<leader>sd` - Search diagnostics
- `<leader>sr` - Resume last search
- `<leader>/` - Search in current buffer

### LSP
- `gd` - Go to definition
- `gr` - Go to references
- `gI` - Go to implementation
- `<leader>D` - Type definition
- `<leader>rn` - Rename symbol
- `<leader>ca` - Code action
- `<leader>d` - Show diagnostics
- `[d` / `]d` - Previous/next diagnostic

### Diagnostics
- `<leader>q` - Open diagnostics list
- `<leader>th` - Toggle inlay hints (if supported)

## Plugins

### Core Plugins
- **lazy.nvim** - Plugin manager
- **plenary.nvim** - Lua utility functions

### UI & Appearance
- **nord.nvim** - Nord color scheme
- **lualine.nvim** - Status line
- **bufferline.nvim** - Buffer tabs
- **alpha-nvim** - Start screen
- **indent-blankline.nvim** - Indentation guides

### File Management
- **neo-tree.nvim** - File explorer
- **telescope.nvim** - Fuzzy finder
- **telescope-fzf-native.nvim** - FZF integration

### Development Tools
- **nvim-lspconfig** - LSP configuration
- **mason.nvim** - LSP server management
- **nvim-treesitter** - Syntax highlighting
- **nvim-cmp** - Autocompletion
- **LuaSnip** - Snippet engine
- **gitsigns.nvim** - Git integration

### Language Servers Configured
- **Lua**: lua_ls
- **Python**: pylsp, ruff
- **JavaScript/TypeScript**: ts_ls
- **Go**: gopls
- **Web**: html, cssls, tailwindcss
- **DevOps**: dockerls, terraformls
- **Data**: jsonls, yamlls, sqlls

## Customization

### Adding New Language Servers
Edit `lua/plugins/lsp.lua` and add your server to the `servers` table:

```lua
servers = {
  -- Add your server here
  rust_analyzer = {},
}
```

### Changing Color Scheme
Edit `lua/plugins/colortheme.lua` to use a different theme.

### Custom Keybindings
Add your keybindings to `lua/keymaps.lua`.

### Editor Options
Modify `lua/options.lua` for editor settings.

## Troubleshooting

### Plugin Installation Issues
- Run `:Lazy clean` and `:Lazy sync` to reinstall plugins
- Check `:checkhealth` for system requirements

### LSP Server Issues
- Run `:Mason` to manage LSP servers
- Check `:LspInfo` for server status
- Verify language server is installed with `:MasonInstall <server>`

### Performance Issues
- Disable unused language servers in `lua/plugins/lsp.lua`
- Reduce Treesitter parsers in `lua/plugins/treesitter.lua`

## Directory Structure

```
~/.config/nvim/
├── init.lua              # Main configuration entry point
├── lazy-lock.json        # Plugin lockfile
├── lua/
│   ├── keymaps.lua      # Key mappings
│   ├── options.lua      # Editor options
│   └── plugins/         # Plugin configurations
│       ├── alpha.lua
│       ├── autocompletion.lua
│       ├── autoformatting.lua
│       ├── bufferline.lua
│       ├── colortheme.lua
│       ├── gitsigns.lua
│       ├── indent-blankline.lua
│       ├── lsp.lua
│       ├── lualine.lua
│       ├── misc.lua
│       ├── neotree.lua
│       ├── telescope.lua
│       └── treesitter.lua
```