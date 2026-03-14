return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    {
      "rcarriga/nvim-notify",
      opts = function()
        -- Derive background from the active colorscheme so this stays correct
        -- if the theme changes. Falls back to a dark neutral if unset (transparent bg).
        local normal_bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
        local bg = normal_bg and string.format("#%06x", normal_bg) or "#1e1e2e"
        return {
          background_colour = bg,
          timeout = 3000,
          max_width = 50,
        }
      end,
    },
  },
  opts = {
    lsp = {
      -- Override markdown rendering so that **cmp** and other plugins use Treesitter
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    -- You can enable a preset for easier configuration
    presets = {
      bottom_search = true,         -- Use a classic bottom cmdline for search
      command_palette = true,       -- Position the cmdline and popupmenu together
      long_message_to_split = true, -- Long messages will be sent to a split
      inc_rename = false,           -- Enables an input dialog for inc-rename.nvim
      lsp_doc_border = false,       -- Add a border to hover docs and signature help
    },
  },
}
