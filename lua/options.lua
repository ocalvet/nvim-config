-- Suppress deprecation warnings (from plugins using old APIs)
vim.g.deprecation_warnings = false

-- Swallow nvim-treesitter install/download progress messages.
-- These bypass noice and use direct nvim_echo, which causes the
-- "Press ENTER or type command to continue" prompt on the alpha dashboard
-- while parsers are being downloaded in the background.
local orig_echo = vim.api.nvim_echo
vim.api.nvim_echo = function(chunks, history, opts)
  for _, chunk in ipairs(chunks or {}) do
    local text = chunk[1]
    if type(text) == "string" and text:match("%[nvim%-treesitter/install") then
      return
    end
  end
  return orig_echo(chunks, history, opts)
end

-- Nerd Font is installed (JetBrains Mono Nerd via install.sh or manually)
-- Enables icons in telescope, lualine, bufferline, etc.
vim.g.have_nerd_font = true

-- Line numbers
vim.wo.number = true
vim.o.relativenumber = true

-- Clipboard
vim.o.clipboard = "unnamedplus"

-- Display
vim.o.wrap = true
vim.o.linebreak = true
vim.o.breakindent = true -- wrapped lines preserve indentation (used when wrap toggled on)
vim.o.termguicolors = true
vim.o.signcolumn = "yes"
vim.o.cursorline = true

-- Scrolling
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8

-- Mouse
vim.o.mouse = "a"

-- Indentation (2 spaces)
vim.o.autoindent = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.expandtab = true

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = true
vim.o.inccommand = "split" -- live preview of :s substitutions in a split

-- Splits
vim.o.splitright = true
vim.o.splitbelow = true

-- Performance
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Persistence
vim.o.undofile = true
vim.o.swapfile = false

-- Completion
vim.o.completeopt = "menu,menuone,noselect"
