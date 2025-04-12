vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "K",  "<cmd>lua vim.lsp.buf.hover()<CR>", { desc = "Hover documentation"})
vim.keymap.set("n", "gd",  "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Go to Definition"})
