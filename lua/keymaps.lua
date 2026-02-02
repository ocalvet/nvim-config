-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable space in normal/visual mode (leader key)
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Save file
vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>sn", "<cmd>noautocmd w<CR>", { desc = "Save without formatting" })

-- Clear search highlights
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

-- Delete single character without copying
vim.keymap.set("n", "x", '"_x', { desc = "Delete char (no yank)" })

-- Vertical scroll and center
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })

-- Find and center
vim.keymap.set("n", "n", "nzzzv", { desc = "Next match and center" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous match and center" })

-- Resize windows with arrows
vim.keymap.set("n", "<Up>", ":resize -2<CR>", { desc = "Decrease height" })
vim.keymap.set("n", "<Down>", ":resize +2<CR>", { desc = "Increase height" })
vim.keymap.set("n", "<Left>", ":vertical resize -2<CR>", { desc = "Decrease width" })
vim.keymap.set("n", "<Right>", ":vertical resize +2<CR>", { desc = "Increase width" })

-- Buffer navigation
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>x", ":bdelete<CR>", { desc = "Close buffer" })
vim.keymap.set("n", "<leader>b", "<cmd>enew<CR>", { desc = "New buffer" })

-- Window management
vim.keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split vertical" })
vim.keymap.set("n", "<leader>ws", "<C-w>s", { desc = "Split horizontal" })
vim.keymap.set("n", "<leader>we", "<C-w>=", { desc = "Equal splits" })
vim.keymap.set("n", "<leader>wx", ":close<CR>", { desc = "Close split" })

-- Navigate splits
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>", { desc = "Go to upper window" })
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>", { desc = "Go to lower window" })
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>", { desc = "Go to left window" })
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", { desc = "Go to right window" })

-- Tab management
vim.keymap.set("n", "<leader>to", ":tabnew<CR>", { desc = "New tab" })
vim.keymap.set("n", "<leader>tx", ":tabclose<CR>", { desc = "Close tab" })
vim.keymap.set("n", "<leader>tn", ":tabn<CR>", { desc = "Next tab" })
vim.keymap.set("n", "<leader>tp", ":tabp<CR>", { desc = "Previous tab" })

-- Toggle line wrapping
vim.keymap.set("n", "<leader>lw", "<cmd>set wrap!<CR>", { desc = "Toggle line wrap" })

-- Stay in indent mode (visual)
vim.keymap.set("v", "<", "<gv", { desc = "Indent left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right" })

-- Keep last yanked when pasting (visual)
vim.keymap.set("v", "p", '"_dP', { desc = "Paste without yank" })

-- Move lines up/down in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Terminal escape
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Diagnostics
vim.keymap.set("n", "[d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Previous diagnostic" })

vim.keymap.set("n", "]d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next diagnostic" })

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostics to loclist" })
