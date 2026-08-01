# AGENTS.md - Neovim Configuration

Guidelines for AI agents working on this Neovim configuration repository.

## Project Overview

Modular Neovim configuration in Lua built with `lazy.nvim` on Neovim 0.12.2+.
Features: LSP (via `mason.nvim` + `nvim-lspconfig`), `blink.cmp` autocompletion, Treesitter main branch, `conform.nvim` + `nvim-lint` formatting/linting, DAP debugging, Neotest, Git integration (Gitsigns + Neogit + Diffview), and Snacks/Noice UI.

## Directory Structure

```
~/.config/nvim/
├── init.lua              # Entry point ({ import = "plugins" })
├── lua/
│   ├── options.lua       # Global vim options & vim.g.have_nerd_font = true
│   ├── keymaps.lua       # Global keybindings
│   ├── filetypes.lua     # Filetype associations
│   └── plugins/          # Plugin specs (one file per group)
└── lazy-lock.json        # Plugin lockfile
```

## Management & Verification Commands

```vim
:checkhealth              " Overall health check (:checkhealth vim.lsp)
:Lazy sync                " Update/sync plugins
:Mason                    " Manage LSP, DAP servers, formatters, linters
:MasonToolsInstall        " Trigger background tool installation
:LspInfo                  " Active LSP status
```

## Core Toolchain Stack

- **Plugin Manager**: `lazy.nvim` loading specs via `{ import = "plugins" }`.
- **Completion**: `blink.cmp` (`version = "1.*"`) with `friendly-snippets` and `lazydev`.
- **LSP / Mason**: `mason-lspconfig` 2.x using Neovim 0.11+ `vim.lsp.config` / `vim.lsp.enable`. Servers include `ts_ls`, `basedpyright`, `rust_analyzer`, `gopls`, `clangd`, etc.
- **Formatting / Linting**: `conform.nvim` (format on save with lsp fallback) + `nvim-lint` (eslint_d, shellcheck, hadolint, checkmake) + `mason-tool-installer` (deferred by 3s with `run_is_silent = true` to avoid startup race conditions).
- **Treesitter**: `nvim-treesitter` main branch with manual `vim.treesitter.start` autocommand.

## Code Style & Conventions

### Indentation & Formatting
- **2 spaces** (no tabs) — set in `options.lua` (`shiftwidth = 2`, `tabstop = 2`, `expandtab = true`).

### Plugin File Structure
```lua
return {
  "author/plugin-name",
  dependencies = { ... },
  event = "VeryLazy",  -- Or appropriate lazy trigger
  config = function()
    require("plugin").setup({})
  end,
}
```

### Keymaps & Autocommands
- Always include `desc` for `which-key` integration:
  ```lua
  vim.keymap.set("n", "<leader>x", function()
    -- action
  end, { desc = "Description" })
  ```
- Use descriptive augroups with hyphens for autocommands:
  ```lua
  vim.api.nvim_create_autocmd("Event", {
    group = vim.api.nvim_create_augroup("group-name", { clear = true }),
    callback = function(event)
      -- handler
    end,
  })
  ```

## Key Prefix Conventions

| Prefix | Purpose |
|--------|---------|
| `<leader>s` | Search (Telescope, Notification history `<leader>sN`) |
| `<leader>g` | Git (Neogit, Diffview, Gitsigns) |
| `<leader>h` | Hunks (Gitsigns) |
| `<leader>d` | Debug / Diagnostics |
| `<leader>t` | Testing (Neotest) |
| `<leader>x` | Trouble (Diagnostics panel) |
| `<leader>c` | Code actions / Formatting |
| `g` | Go to (LSP navigation: `gd`, `gr`, `gI`) |
| `[` / `]` | Previous / Next (`[d`, `]d` diagnostics, `[t`, `]t` tests) |

## Testing & Verification Workflow

1. Edit configuration files in `lua/plugins/` or `lua/`.
2. Save file and reload in Neovim (`:source %` or restart).
3. Run `:Lazy sync` if plugins changed.
4. Run `:checkhealth` or `:checkhealth vim.lsp` to verify LSPs and dependencies.
