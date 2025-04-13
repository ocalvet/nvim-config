require("conform").setup({
  formatters_by_ft = {
    go = { "gofmt" },
    python = { "black" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
    json = { "prettier" },
    markdown = { "prettier" },
    lua = { "stylua" },
  },
  -- format_on_save = {
  --   lsp_fallback = true,
  --   timeout_ms = 2000,
  -- },
})

-- Function to exit visual mode after formatting
local function format_and_exit_visual_mode()
  require("conform").format({ async = true }, function(err)
    if not err then
      local mode = vim.api.nvim_get_mode().mode
      if vim.startswith(mode:lower(), "v") then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
      end
    end
  end)
end

-- Keybinding for formatting the entire document in normal mode
vim.keymap.set("n", "<leader>f", function()
  require("conform").format({ async = true })
end, { desc = "Format entire document" })

-- Keybinding for formatting the selected code block in visual mode
vim.keymap.set("v", "<leader>f", format_and_exit_visual_mode, { desc = "Format selected code" })
