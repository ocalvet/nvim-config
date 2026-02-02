-- Better diagnostics UI
-- Provides a prettier and more functional diagnostics list
return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "Trouble",
  keys = {
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Toggle Trouble" },
    { "<leader>xw", "<cmd>Trouble diagnostics toggle<cr>", desc = "Workspace Diagnostics" },
    { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Document Diagnostics" },
    { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Location List" },
    { "<leader>xq", "<cmd>Trouble quickfix toggle<cr>", desc = "Quickfix List" },
    { "<leader>xr", "<cmd>Trouble lsp_references toggle<cr>", desc = "LSP References" },
  },
  opts = {},
}
