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

## System Requirements

### Critical Dependencies (Required for Basic Functionality)

#### Core System Requirements
- **Neovim 0.10+** (minimum 0.8, but 0.10+ recommended for full feature support)
- **Git** (for plugin management and version control features)
- **C/C++ Compiler** (gcc, clang, or Visual Studio Build Tools on Windows)
- **Make** (for building telescope-fzf-native and other native extensions)
- **Curl** (for downloading packages and tools)

#### Programming Language Runtimes
- **Node.js 18+** and **npm** (for JavaScript/TypeScript LSP servers, formatters, and debug adapters)
- **Python 3.8+** and **pip** (for Python LSP servers, formatters, and debug adapters)
- **Go 1.19+** (for Go LSP server and debug adapter)

#### Python Virtual Environment Support
- **venv** (built-in Python module for virtual environments)
- **virtualenv** (alternative virtual environment tool)
- **uv** (ultra-fast Python package installer and resolver)
- **pyenv** (Python version management)
- **conda/mamba** (Anaconda/Mambaforge environments)

#### Package Managers
- **Mason** (auto-installed by the configuration)
- **Lazy.nvim** (auto-installed by the configuration)

### Essential Tools (Installed automatically via Mason)

#### Language Servers
- **lua_ls** (Lua Language Server)
- **pylsp** (Python LSP Server)
- **ruff** (Python linter and formatter)
- **ts_ls** (TypeScript Language Server)
- **gopls** (Go Language Server)
- **html** (HTML Language Server)
- **cssls** (CSS Language Server)
- **tailwindcss** (Tailwind CSS Language Server)
- **dockerls** (Docker Language Server)
- **terraformls** (Terraform Language Server)
- **jsonls** (JSON Language Server)
- **yamlls** (YAML Language Server)
- **sqlls** (SQL Language Server)

#### Formatters and Linters
- **prettier** (JavaScript/TypeScript/HTML/CSS formatter)
- **eslint_d** (JavaScript/TypeScript linter)
- **stylua** (Lua formatter)
- **shfmt** (Shell script formatter)
- **checkmake** (Makefile linter)

#### Debug Adapters
- **node-debug2-adapter** (Node.js/JavaScript debugger)
- **debugpy** (Python debugger)
- **delve** (Go debugger)

#### Testing Tools
- **pytest** (Python testing framework)
- **jest** (JavaScript testing framework)
- **go test** (Go testing framework)

### Optional but Recommended

#### Fonts
- **Nerd Font** (for icons in file explorer, status line, and UI elements)
  - Recommended: JetBrains Mono Nerd Font, Fira Code Nerd Font, or Hack Nerd Font

#### Terminal Enhancements
- **Tmux** (for vim-tmux-navigator plugin functionality)
- **Ripgrep** (for faster grep operations in Telescope)
- **fd** (for faster file finding in Telescope)

#### Additional Language Tools
- **Rust** and **Cargo** (if working with Rust projects)
- **Java 11+** (if working with Java projects)
- **Docker** (for containerized development)
- **Terraform** (for infrastructure as code)

#### Git Integration Requirements
- **Git 2.25+** (for diffview.nvim and advanced Git features)
- **GitHub CLI** (optional, for vim-rhubarb GitHub integration): `gh`
- **Git configuration** with user.name and user.email set

### Platform-Specific Installation

#### Ubuntu/Debian
```bash
# Update package list
sudo apt update

# Core dependencies
sudo apt install -y neovim git build-essential curl nodejs npm python3 python3-pip

# Python virtual environment tools
sudo apt install -y python3-venv python3-virtualenv
pip install --user uv pipenv

# Optional tools
sudo apt install -y tmux ripgrep fd-find

# Install Go (if not already installed)
wget https://golang.org/dl/go1.21.0.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.21.0.linux-amd64.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc

# Install a Nerd Font
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
unzip JetBrainsMono.zip -d ~/.local/share/fonts/
fc-cache -fv
```

#### macOS
```bash
# Install Homebrew if not already installed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Core dependencies
brew install neovim git make curl node python3 go

# Python virtual environment tools
brew install pyenv
pip install uv pipenv

# Optional tools
brew install tmux ripgrep fd

# Install a Nerd Font
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono-nerd-font
```

#### Windows
```powershell
# Install Chocolatey if not already installed
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Core dependencies
choco install -y neovim git make curl nodejs python3 golang

# Python virtual environment tools
pip install uv pipenv virtualenv

# Optional tools
choco install -y tmux ripgrep fd

# Install Visual Studio Build Tools (required for native compilation)
choco install -y visualstudio2022buildtools

# Install a Nerd Font
choco install -y font-jetbrainsmono-nf
```

### Verification Commands

After installation, verify your setup:

```bash
# Check core tools
nvim --version
git --version
node --version
npm --version
python3 --version
go version
make --version

# Check Python virtual environment tools
python3 -m venv --help
uv --version
pipenv --version

# Check optional tools
tmux -V
rg --version
fd --version

# Check if Nerd Font is installed (look for icons in output)
echo "  "
```

### Minimum System Requirements

#### Hardware
- **RAM**: 4GB minimum, 8GB recommended
- **Storage**: 2GB free space for plugins and language servers
- **CPU**: Any modern processor (x86_64 or ARM64)

#### Network
- **Internet connection** required for initial setup and package downloads
- **Firewall**: Allow connections to package repositories and language server downloads

### Troubleshooting System Dependencies

#### Common Issues and Solutions

1. **Mason installation failures**
   - Ensure you have proper internet connectivity
   - Check if your system has the required build tools
   - Run `:checkhealth mason` in Neovim

2. **telescope-fzf-native build failures**
   - Ensure `make` and a C compiler are installed
   - On Windows, ensure Visual Studio Build Tools are properly installed

3. **LSP servers not starting**
   - Verify the corresponding language runtime is installed
   - Check `:LspInfo` for error messages
   - Ensure the language server binary is in your PATH

4. **Python-related issues**
   - Ensure `python3` and `pip` are available in PATH
   - For Python debugging, ensure `debugpy` is installed: `pip install debugpy`

5. **Node.js-related issues**
   - Ensure Node.js version is 18 or higher
   - Clear npm cache: `npm cache clean --force`
   - Check npm global directory permissions

### Python Virtual Environment Usage

#### Creating Virtual Environments

**Using venv (built-in)**:
```bash
# Create a virtual environment
python3 -m venv myproject-env

# Activate the environment
source myproject-env/bin/activate  # Linux/macOS
myproject-env\Scripts\activate     # Windows

# Install packages
pip install pytest debugpy
```

**Using uv (ultra-fast)**:
```bash
# Create a virtual environment
uv venv myproject-env

# Activate the environment
source myproject-env/bin/activate  # Linux/macOS
myproject-env\Scripts\activate     # Windows

# Install packages with uv
uv pip install pytest debugpy
```

**Using virtualenv**:
```bash
# Create a virtual environment
virtualenv myproject-env

# Activate and install packages
source myproject-env/bin/activate
pip install pytest debugpy
```

#### Virtual Environment Best Practices

1. **Always activate your virtual environment** before starting Neovim for Python projects
2. **Install debugpy in each virtual environment** for debugging support:
   ```bash
   pip install debugpy
   ```
3. **Install pytest in each virtual environment** for testing:
   ```bash
   pip install pytest
   ```
4. **Use project-specific requirements files**:
   ```bash
   pip install -r requirements.txt
   pip install -r requirements-dev.txt
   ```

#### Automatic Virtual Environment Detection

The configuration automatically detects:
- **Active virtual environments** (via `VIRTUAL_ENV` environment variable)
- **Poetry environments** (via `pyproject.toml`)
- **Pipenv environments** (via `Pipfile`)
- **Conda environments** (via `CONDA_PREFIX`)

#### Troubleshooting Virtual Environments

1. **LSP not finding packages**: Ensure the virtual environment is activated before starting Neovim
2. **Debugger not working**: Install `debugpy` in the active virtual environment
3. **Tests not running**: Install `pytest` in the active virtual environment
4. **Import errors**: Verify packages are installed in the correct virtual environment

### Performance Optimization

#### For Low-Resource Systems
- Disable unused language servers in `lua/plugins/lsp.lua`
- Reduce Treesitter parsers in `lua/plugins/treesitter.lua`
- Disable resource-intensive plugins like `nvim-dap` if not needed

#### For High-Performance Systems
- Enable all available language servers
- Use faster alternatives like `ripgrep` and `fd`
- Consider using a terminal with GPU acceleration

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

### Debugging (DAP)
- `<F5>` - Continue/Start debugging
- `<F10>` - Step over
- `<F11>` - Step into
- `<F12>` - Step out
- `<leader>db` - Toggle breakpoint
- `<leader>dB` - Set conditional breakpoint
- `<leader>du` - Toggle debug UI
- `<leader>dr` - Open debug REPL
- `<leader>dl` - Run last debug session

### Testing (Neotest)
- `<leader>tr` - Run nearest test
- `<leader>tf` - Run tests in current file
- `<leader>td` - Debug nearest test
- `<leader>ts` - Stop running tests
- `<leader>tt` - Toggle test summary
- `<leader>to` - Show test output
- `[t` / `]t` - Jump to previous/next failed test

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

### Plugin-Specific Requirements

#### telescope-fzf-native.nvim
- **Required**: `make`, C compiler (gcc/clang/MSVC)
- **Purpose**: Provides native FZF sorting for better performance
- **Build**: Automatically built on plugin installation

#### nvim-treesitter
- **Required**: `git`, C compiler, `node` (for some parsers)
- **Purpose**: Syntax highlighting and code parsing
- **Auto-install**: Parsers are installed automatically on first use

#### mason.nvim
- **Required**: `curl`, `git`, `unzip`, `node`, `npm`
- **Purpose**: Package manager for LSP servers, formatters, and tools
- **Network**: Requires internet access for package downloads

#### nvim-dap (Debug Adapter Protocol)
- **Python**: Requires `debugpy` package (install in each virtual environment)
- **JavaScript/Node.js**: Requires Node.js runtime
- **Go**: Requires `delve` debugger
- **Purpose**: Multi-language debugging support

#### Python Virtual Environment Integration
- **Automatic Detection**: The configuration automatically detects and uses activated virtual environments
- **LSP Server**: pylsp and ruff will use the Python interpreter from the active virtual environment
- **Debugger**: nvim-dap-python will use the Python interpreter from the active virtual environment
- **Testing**: neotest-python will use pytest from the active virtual environment
- **Formatters**: Ruff and other formatters will use the active virtual environment's packages

#### neotest
- **Python**: Requires `pytest` for running tests
- **JavaScript**: Requires `jest` for running tests
- **Go**: Uses built-in Go testing framework
- **Purpose**: Test runner and results display

#### diffview.nvim
- **Required**: `git 2.25+`
- **Purpose**: Git diff visualization and merge conflict resolution
- **Features**: Requires Git repository to function

#### vim-rhubarb
- **Optional**: GitHub CLI (`gh`) for enhanced GitHub integration
- **Purpose**: GitHub integration for vim-fugitive
- **Features**: Browse GitHub repositories, issues, and PRs

#### none-ls.nvim (null-ls)
- **Formatters**: `prettier`, `stylua`, `shfmt`
- **Linters**: `eslint_d`, `checkmake`
- **Purpose**: Code formatting and linting integration
- **Install**: Tools are automatically installed via Mason

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

### Testing Framework Issues
- **Python**: Ensure `pytest` is installed: `pip install pytest`
- **JavaScript**: Ensure `jest` is installed: `npm install -g jest` or use project-local installation
- **Go**: Go testing is built-in, but ensure your Go installation is complete

### Debug Adapter Issues
- **Python**: Install debugpy: `pip install debugpy`
- **JavaScript/Node.js**: Ensure Node.js debugger is available through Mason
- **Go**: Install Delve: `go install github.com/go-delve/delve/cmd/dlv@latest`

### Python Virtual Environment Issues
- **LSP not working**: Restart Neovim after activating virtual environment
- **Packages not found**: Verify virtual environment is activated: `which python`
- **Multiple Python versions**: Use `pyenv` to manage Python versions
- **uv not installing packages**: Ensure uv is properly installed: `uv --version`
- **Virtual environment not detected**: Check environment variables: `echo $VIRTUAL_ENV`

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
│       ├── dap.lua
│       ├── diffview.lua
│       ├── gitsigns.lua
│       ├── indent-blankline.lua
│       ├── lsp.lua
│       ├── lualine.lua
│       ├── misc.lua
│       ├── neotree.lua
│       ├── surround.lua
│       ├── telescope.lua
│       ├── testing.lua
│       ├── treesitter.lua
│       └── which-key.lua
```

## Quick Reference

### Health Check Commands
```vim
:checkhealth                    " Check overall Neovim health
:checkhealth mason              " Check Mason package manager
:checkhealth lsp                " Check LSP configuration
:checkhealth treesitter         " Check Treesitter configuration
:checkhealth telescope          " Check Telescope configuration
```

### Mason Commands
```vim
:Mason                          " Open Mason UI
:MasonInstall <package>         " Install a package
:MasonUninstall <package>       " Uninstall a package
:MasonUpdate                    " Update all packages
:MasonLog                       " View Mason logs
```

### LSP Commands
```vim
:LspInfo                        " Show LSP server information
:LspStart                       " Start LSP server
:LspStop                        " Stop LSP server
:LspRestart                     " Restart LSP server
```

### Lazy Plugin Manager Commands
```vim
:Lazy                           " Open Lazy UI
:Lazy sync                      " Update and install plugins
:Lazy clean                     " Remove unused plugins
:Lazy update                    " Update plugins
:Lazy profile                   " Profile plugin loading
```

### Debugging Commands
```vim
:DapToggleBreakpoint           " Toggle breakpoint
:DapContinue                   " Continue debugging
:DapStepOver                   " Step over
:DapStepInto                   " Step into
:DapStepOut                    " Step out
```

### Testing Commands
```vim
:Neotest run                   " Run nearest test
:Neotest run file              " Run current file tests
:Neotest summary               " Show test summary
:Neotest output                " Show test output
```