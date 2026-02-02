# Neovim Configuration Usage Guide

This guide covers all keybindings and workflows for this Neovim setup.

## Table of Contents

1. [Getting Started](#getting-started)
2. [Basic Navigation](#basic-navigation)
3. [File Management](#file-management)
4. [Search & Find](#search--find)
5. [Git Workflow](#git-workflow)
6. [LSP Features](#lsp-features)
7. [Debugging](#debugging)
8. [Testing](#testing)
9. [Editing Enhancements](#editing-enhancements)

---

## Getting Started

### Leader Key

The **leader key** is `<Space>`. Most custom keybindings start with it.

### Getting Help

| Keymap | Action |
|--------|--------|
| `<leader>sh` | Search help tags |
| `<leader>sk` | Search all keymaps |
| Press `?` in any plugin | Show plugin help |

### Plugin Management

```vim
:Lazy              " Open plugin manager
:Lazy sync         " Update all plugins
:Mason             " Manage LSP servers
:checkhealth       " Verify setup
```

---

## Basic Navigation

### Movement

| Keymap | Action |
|--------|--------|
| `s{char}{char}` | **Flash jump** - Type 2 chars to jump anywhere |
| `S` | Flash treesitter selection |
| `f/F/t/T` | Enhanced with labels (via flash.nvim) |
| `<C-d>` | Scroll down (centered) |
| `<C-u>` | Scroll up (centered) |
| `n/N` | Next/prev search match (centered) |

### Windows

| Keymap | Action |
|--------|--------|
| `<leader>v` | Split vertical |
| `<leader>s` | Split horizontal |
| `<leader>se` | Make splits equal |
| `<leader>sx` | Close current split |
| `<C-h/j/k/l>` | Navigate between splits |
| Arrow keys | Resize windows |

### Buffers

| Keymap | Action |
|--------|--------|
| `<Tab>` | Next buffer |
| `<S-Tab>` | Previous buffer |
| `<leader>x` | Close buffer |
| `<leader>b` | New buffer |
| `<leader><leader>` | List all buffers |

### Tabs

| Keymap | Action |
|--------|--------|
| `<leader>to` | New tab |
| `<leader>tx` | Close tab |
| `<leader>tn` | Next tab |
| `<leader>tp` | Previous tab |

---

## File Management

### Neo-tree (File Explorer)

| Keymap | Action |
|--------|--------|
| `<leader>e` | Toggle file explorer |
| `\` | Reveal current file |
| `a` | Add file/directory |
| `d` | Delete |
| `r` | Rename |
| `c` | Copy |
| `m` | Move |
| `H` | Toggle hidden files |
| `?` | Show all mappings |

### Quick Actions

| Keymap | Action |
|--------|--------|
| `<C-s>` | Save file |
| `<leader>sn` | Save without formatting |

---

## Search & Find

### Telescope (Fuzzy Finder)

| Keymap | Action |
|--------|--------|
| `<leader>sf` | **Find files** |
| `<leader>sg` | **Live grep** (search in files) |
| `<leader>sw` | Search word under cursor |
| `<leader>sb` | Search buffers |
| `<leader>sh` | Search help |
| `<leader>sk` | Search keymaps |
| `<leader>sd` | Search diagnostics |
| `<leader>sr` | Resume last search |
| `<leader>s.` | Recent files |
| `<leader>s/` | Search in open files |
| `<leader>/` | Fuzzy search current buffer |

**Inside Telescope:**
| Key | Action |
|-----|--------|
| `<C-j/k>` | Navigate results |
| `<C-l>` or `<CR>` | Open selection |
| `<C-s>` | Toggle flash (jump to result) |

---

## Git Workflow

This config provides a unified Git experience with three integrated tools:
- **Neogit** - Git status and operations (like Magit)
- **Gitsigns** - Inline git info and hunk operations
- **Diffview** - Visual diff viewer

### Neogit (Git Status)

| Keymap | Action |
|--------|--------|
| `<leader>gg` | **Open Neogit status** |
| `<leader>gc` | Commit |
| `<leader>gP` | Push |
| `<leader>gp` | Pull |
| `<leader>gb` | Branch popup |

**Inside Neogit:**
- `s` - Stage file/hunk
- `u` - Unstage
- `c` - Commit popup
- `p` - Push popup
- `F` - Pull popup
- `?` - Help

### Gitsigns (Hunk Operations)

| Keymap | Action |
|--------|--------|
| `]h` | Next hunk |
| `[h` | Previous hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hS` | Stage buffer |
| `<leader>hR` | Reset buffer |
| `<leader>hu` | Undo stage hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame line |
| `<leader>hB` | Toggle line blame |
| `<leader>hd` | Diff this |
| `<leader>hD` | Diff against ~ |

**Text Object:** `ih` selects the current hunk (works in visual/operator mode)

### Diffview (Visual Diffs)

| Keymap | Action |
|--------|--------|
| `<leader>gd` | Open diffview |
| `<leader>gD` | Diff vs previous commit |
| `<leader>gh` | File history (all files) |
| `<leader>gH` | File history (current file) |
| `<leader>gx` | Close diffview |

**Inside Diffview:**
- `<Tab>/<S-Tab>` - Next/prev file
- `-` - Toggle stage
- `S` - Stage all
- `U` - Unstage all
- `X` - Restore file
- `[x/]x` - Prev/next conflict
- `<leader>co` - Choose ours
- `<leader>ct` - Choose theirs

### Typical Git Workflow

1. **Check status:** `<leader>gg`
2. **Review changes:** Navigate with `]h`/`[h`, preview with `<leader>hp`
3. **Stage changes:** `<leader>hs` per hunk or `s` in Neogit
4. **Commit:** `<leader>gc` or `c` in Neogit
5. **Push:** `<leader>gP`

---

## LSP Features

### Navigation

| Keymap | Action |
|--------|--------|
| `gd` | Go to definition |
| `gr` | Go to references |
| `gI` | Go to implementation |
| `gD` | Go to declaration |
| `<leader>D` | Type definition |
| `<leader>ds` | Document symbols |
| `<leader>ws` | Workspace symbols |

### Actions

| Keymap | Action |
|--------|--------|
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `K` | Hover documentation |
| `<leader>th` | Toggle inlay hints |

### Diagnostics

| Keymap | Action |
|--------|--------|
| `<leader>d` | Show diagnostic float |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |
| `<leader>q` | Send to location list |

### Trouble (Diagnostics Panel)

| Keymap | Action |
|--------|--------|
| `<leader>xx` | Toggle Trouble |
| `<leader>xw` | Workspace diagnostics |
| `<leader>xd` | Document diagnostics |
| `<leader>xq` | Quickfix list |
| `<leader>xl` | Location list |
| `<leader>xr` | LSP references |

---

## Debugging

### DAP (Debug Adapter Protocol)

| Keymap | Action |
|--------|--------|
| `<F5>` | Start/Continue debugging |
| `<F10>` | Step over |
| `<F11>` | Step into |
| `<F12>` | Step out |
| `<leader>db` | Toggle breakpoint |
| `<leader>dB` | Conditional breakpoint |
| `<leader>du` | Toggle debug UI |
| `<leader>dr` | Open REPL |
| `<leader>dl` | Run last session |

### Debug Inspection

| Keymap | Action |
|--------|--------|
| `<leader>dh` | Hover variable |
| `<leader>dp` | Preview variable |
| `<leader>df` | Show frames |
| `<leader>ds` | Show scopes |

### Supported Languages

- **Python** - Requires `debugpy` (`pip install debugpy`)
- **JavaScript/TypeScript** - Uses node-debug2-adapter
- **Go** - Requires `delve`

---

## Testing

### Neotest

| Keymap | Action |
|--------|--------|
| `<leader>tr` | **Run nearest test** |
| `<leader>tf` | Run file tests |
| `<leader>td` | Debug nearest test |
| `<leader>ts` | Stop running tests |
| `<leader>tt` | Toggle summary |
| `<leader>to` | Show output |
| `<leader>tO` | Toggle output panel |
| `<leader>tw` | Watch file tests |
| `[t` | Previous failed test |
| `]t` | Next failed test |

### Supported Frameworks

- **Python** - pytest
- **JavaScript** - Jest
- **Go** - go test

---

## Editing Enhancements

### Surround

| Keymap | Action |
|--------|--------|
| `ys{motion}{char}` | Add surround |
| `yss{char}` | Surround line |
| `ds{char}` | Delete surround |
| `cs{old}{new}` | Change surround |
| `S{char}` | Surround selection (visual) |

**Examples:**
- `ysiw"` - Surround word with quotes
- `cs"'` - Change double to single quotes
- `ds(` - Delete parentheses
- `yst` - Surround with HTML tag

### Comments

- `gcc` - Toggle line comment
- `gc{motion}` - Toggle comment
- `gbc` - Toggle block comment

### Auto-pairs

Automatically closes `()`, `[]`, `{}`, `""`, `''`

---

## UI Features

### Noice (Modern UI)

| Keymap | Action |
|--------|--------|
| `<leader>nh` | Notification history |
| `<leader>nl` | Last notification |
| `<leader>nd` | Dismiss notifications |

### Which-Key

Press `<leader>` and wait to see available keybindings.

---

## Quick Reference Card

### Most Used

| Keymap | Action |
|--------|--------|
| `<leader>sf` | Find files |
| `<leader>sg` | Search in files |
| `<leader>e` | File explorer |
| `<leader>gg` | Git status |
| `gd` | Go to definition |
| `<leader>ca` | Code action |
| `<leader>tr` | Run test |
| `s{char}{char}` | Jump to location |

### File Operations

| Keymap | Action |
|--------|--------|
| `<C-s>` | Save |
| `<leader>x` | Close buffer |
| `<Tab>/<S-Tab>` | Next/prev buffer |

### Window Management

| Keymap | Action |
|--------|--------|
| `<leader>v` | Vertical split |
| `<leader>s` | Horizontal split |
| `<C-h/j/k/l>` | Navigate splits |

---

## Customization

### Adding Keymaps

Edit `~/.config/nvim/lua/keymaps.lua`:

```lua
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
```

### Editor Options

Edit `~/.config/nvim/lua/options.lua`:

```lua
vim.o.tabstop = 4       -- Tab width
vim.o.shiftwidth = 4    -- Indent width
vim.o.relativenumber = false  -- Absolute line numbers
```

### Adding Plugins

Create a file in `~/.config/nvim/lua/plugins/`:

```lua
return {
  "author/plugin-name",
  config = function()
    require("plugin-name").setup({})
  end,
}
```

Then add to `init.lua`:

```lua
require("plugins.your-plugin"),
```

---

## Troubleshooting

### Common Commands

```vim
:checkhealth          " Check for issues
:Lazy sync            " Reinstall plugins
:Mason                " Manage LSP servers
:LspInfo              " Check LSP status
:LspRestart           " Restart LSP
```

### Reset Configuration

```bash
# Remove plugin data
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim

# Restart Neovim
nvim
```
