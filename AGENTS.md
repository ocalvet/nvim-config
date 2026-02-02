# AGENTS.md - Neovim Configuration

Guidelines for AI agents working on this Neovim configuration.

## Project Overview

Neovim configuration in Lua using lazy.nvim. Features: LSP, Telescope, Treesitter,
DAP debugging, Neotest, Git integration (Gitsigns + Neogit + Diffview), and modern UI.

## Directory Structure

```
~/.config/nvim/
├── init.lua              # Entry point
├── lua/
│   ├── options.lua       # Vim options
│   ├── keymaps.lua       # Global keybindings
│   └── plugins/          # Plugin configs (one file per plugin)
└── lazy-lock.json        # Plugin lockfile
```

## Commands

### Health & Management
```vim
:checkhealth              " Overall health
:Lazy sync                " Update plugins
:Mason                    " Manage LSP servers
:LspInfo                  " LSP status
```

### Testing
- `<leader>tr` - Run nearest test
- `<leader>tf` - Run file tests
- `<leader>td` - Debug test
- `<leader>tt` - Toggle summary

### Debugging
- `<F5>` - Start/continue
- `<F10/11/12>` - Step over/into/out
- `<leader>db` - Toggle breakpoint

### Git
- `<leader>gg` - Neogit status
- `<leader>hs` - Stage hunk
- `<leader>hp` - Preview hunk
- `<leader>gd` - Diffview

## Code Style

### Indentation
- **2 spaces** (no tabs)
- Set in `options.lua`: `shiftwidth = 2`, `tabstop = 2`, `expandtab = true`

### Plugin File Structure

```lua
return {
  "author/plugin-name",
  dependencies = { ... },
  event = "VeryLazy",  -- Lazy loading
  config = function()
    require("plugin").setup({})
  end,
}
```

### Keymaps

```lua
vim.keymap.set("n", "<leader>x", function()
  -- action
end, { desc = "Description" })
```

Always include `desc` for which-key integration.

### Autocommands

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
| `<leader>s` | Search (Telescope) |
| `<leader>g` | Git (Neogit, Diffview) |
| `<leader>h` | Hunks (Gitsigns) |
| `<leader>d` | Debug/Diagnostics |
| `<leader>t` | Testing |
| `<leader>x` | Trouble |
| `<leader>c` | Code actions |
| `g` | Go to (LSP) |
| `[` / `]` | Previous/Next |

## Naming Conventions

- **Files**: lowercase with hyphens (`indent-blankline.lua`)
- **Variables**: snake_case
- **Augroups**: descriptive with hyphens

## Adding Plugins

1. Create `lua/plugins/name.lua`
2. Return lazy.nvim spec
3. Add `require("plugins.name")` to `init.lua`
4. Run `:Lazy sync`

## Testing Changes

1. Save file
2. `:source %` or restart Neovim
3. `:checkhealth`
4. Test functionality

## External Dependencies

- Node.js 18+, Python 3.8+, Go 1.19+
- ripgrep, fd, make, C compiler
