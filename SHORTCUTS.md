# Neovim Quick Shortcuts

Most useful keybindings for this config, pulled from the actual Lua mappings.

- Leader key: `<Space>`
- Tip: press `<Space>` and wait to see available mappings with which-key

## Everyday Essentials

| Keymap | Action |
|--------|--------|
| `<leader>sf` | Find files |
| `<leader>sg` | Live grep (project search) |
| `<leader>e` | Toggle file explorer |
| `<leader><leader>` | Find open buffers |
| `gd` | Go to definition |
| `<leader>ca` | Code action |
| `<leader>rn` | Rename symbol |
| `<leader>gg` | Open Git status (Neogit) |
| `<leader>tr` | Run nearest test |
| `<F5>` | Start/continue debugging |

## Search and Replace

| Keymap | Action |
|--------|--------|
| `<leader>sf` | Search files |
| `<leader>sg` | Search by grep |
| `<leader>sw` | Search word under cursor |
| `<leader>s.` | Recent files |
| `<leader>/` | Fuzzy search current buffer |
| `<leader>s/` | Search only open files |
| `<leader>sd` | Search diagnostics |
| `<leader>sk` | Search keymaps |
| `<leader>sh` | Search help tags |
| `<leader>ss` | Telescope pickers |
| `<leader>sr` | Search and replace (project-wide) |
| `<leader>sR` | Search and replace (cursor word) |
| `<leader>sr` (visual) | Search and replace (selection) |

Note: `:Telescope resume` is available, but `<leader>sr` is intentionally used for search-and-replace.

## Files, Buffers, Windows, Tabs

| Keymap | Action |
|--------|--------|
| `<C-s>` | Save file |
| `<leader>sn` | Save without formatting |
| `<Tab>` / `<S-Tab>` | Next / previous buffer |
| `<leader>bd` | Close buffer |
| `<leader>b` | New empty buffer |
| `<leader>wv` | Split vertical |
| `<leader>ws` | Split horizontal |
| `<leader>we` | Equalize split sizes |
| `<leader>wx` | Close split |
| `<C-h/j/k/l>` | Move between splits |
| Arrow keys | Resize split |
| `<leader>To` | New tab |
| `<leader>Tx` | Close tab |
| `<leader>Tn` | Next tab |
| `<leader>Tp` | Previous tab |
| `<leader>e` | Toggle Neo-tree |
| `\\` | Reveal current file in Neo-tree |

## LSP, Diagnostics, and Trouble

| Keymap | Action |
|--------|--------|
| `gd` | Go to definition |
| `gr` | Go to references |
| `gI` | Go to implementation |
| `gD` | Go to declaration |
| `<leader>D` | Type definition |
| `<leader>ds` | Document symbols |
| `<leader>fws` | Workspace symbols |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `<leader>th` | Toggle inlay hints |
| `[d` / `]d` | Prev / next diagnostic |
| `<leader>d` | Show diagnostic float |
| `<leader>q` | Diagnostics to location list |
| `<leader>xx` | Toggle Trouble |
| `<leader>xw` | Workspace diagnostics |
| `<leader>xd` | Document diagnostics |
| `<leader>xq` | Quickfix list |
| `<leader>xl` | Location list |
| `<leader>xr` | LSP references |

## Git

| Keymap | Action |
|--------|--------|
| `<leader>gg` | Neogit status |
| `<leader>gc` | Neogit commit |
| `<leader>gP` | Neogit push |
| `<leader>gp` | Neogit pull |
| `]h` / `[h` | Next / previous hunk |
| `<leader>hs` / `<leader>hr` | Stage / reset hunk |
| `<leader>hS` / `<leader>hR` | Stage / reset buffer |
| `<leader>hu` | Undo stage hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hb` / `<leader>hB` | Blame line / toggle line blame |
| `<leader>hd` / `<leader>hD` | Diff this / diff against `~` |
| `<leader>gd` | Open Diffview |
| `<leader>gD` | Diff vs previous commit |
| `<leader>gh` | Repo file history |
| `<leader>gH` | Current file history |
| `<leader>gx` | Close Diffview |

## Testing and Debugging

| Keymap | Action |
|--------|--------|
| `<leader>tr` | Run nearest test |
| `<leader>tf` | Run current file tests |
| `<leader>td` | Debug nearest test |
| `<leader>ts` | Stop test |
| `<leader>ta` | Attach to running test |
| `<leader>to` | Open test output |
| `<leader>tO` | Toggle test output panel |
| `<leader>tt` | Toggle test summary |
| `<leader>tw` | Watch tests in current file |
| `[t` / `]t` | Prev / next failed test |
| `<F5>` | Continue |
| `<F10>` | Step over |
| `<F11>` | Step into |
| `<F12>` | Step out |
| `<leader>db` | Toggle breakpoint |
| `<leader>dB` | Conditional breakpoint |
| `<leader>lp` | Log point |
| `<leader>du` | Toggle debug UI |
| `<leader>dr` | Open debug REPL |
| `<leader>dl` | Run last debug session |
| `<leader>dh` / `<leader>dp` | Debug hover / preview |
| `<leader>df` / `<leader>dS` | Debug frames / scopes |

## Motion and Utilities

| Keymap | Action |
|--------|--------|
| `s` | Flash jump |
| `S` | Flash Treesitter |
| `<leader>cf` | Format buffer |
| `<leader>a` | Toggle code outline (Aerial) |
| `[a` / `]a` | Prev / next symbol (Aerial) |
| `<leader>tm` | Toggle markdown rendering |
| `<leader>sN` | Notification history |
| `<leader>un` | Dismiss notifications |
| `<leader>lw` | Toggle line wrap |
| `<Esc><Esc>` (terminal mode) | Exit terminal mode |
