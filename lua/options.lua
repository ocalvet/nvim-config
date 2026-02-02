-- Suppress deprecation warnings (from plugins using old APIs)
vim.g.deprecation_warnings = false

-- Line numbers
vim.wo.number = true
vim.o.relativenumber = true

-- Clipboard
vim.o.clipboard = "unnamedplus"

-- Display
vim.o.wrap = false
vim.o.linebreak = true
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
