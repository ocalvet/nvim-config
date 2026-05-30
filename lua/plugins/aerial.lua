return {
  "stevearc/aerial.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  cmd = { "AerialToggle", "AerialOpen", "AerialClose", "AerialNext", "AerialPrev", "AerialInfo" },
  keys = {
    {
      "<leader>a",
      function() require("aerial").toggle({ focus = false }) end,
      desc = "Toggle code outline (Aerial)",
    },
    {
      "[a",
      function() require("aerial").prev() end,
      desc = "Aerial: prev symbol",
    },
    {
      "]a",
      function() require("aerial").next() end,
      desc = "Aerial: next symbol",
    },
    {
      "<leader>sa",
      function()
        local ok = pcall(require("telescope").extensions.aerial.aerial)
        if not ok then
          require("aerial").snacks_picker()
        end
      end,
      desc = "Search symbols (Aerial)",
    },
  },
  config = function()
    require("aerial").setup({
      backends = { "treesitter", "lsp", "markdown", "asciidoc", "man" },

      layout = {
        max_width = { 40, 0.2 },
        min_width = 25,
        default_direction = "prefer_right",
        placement = "window",
        resize_to_content = true,
        preserve_equality = false,
      },

      attach_mode = "window",
      close_on_select = false,
      show_guides = true,
      highlight_on_hover = true,
      highlight_on_jump = 300,
      nerd_font = "auto",

      filter_kind = {
        "Class",
        "Constructor",
        "Enum",
        "Function",
        "Interface",
        "Method",
        "Module",
        "Namespace",
        "Package",
        "Struct",
        "Trait",
        "Type",
        "TypeParameter",
      },

      on_attach = function(bufnr)
        vim.keymap.set("n", "{", function() require("aerial").prev() end, { buffer = bufnr, desc = "Aerial: prev symbol" })
        vim.keymap.set("n", "}", function() require("aerial").next() end, { buffer = bufnr, desc = "Aerial: next symbol" })
      end,
    })

    pcall(require("telescope").load_extension, "aerial")
  end,
}
