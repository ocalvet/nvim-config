return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  ft = { "markdown", "quarto", "rmd" },
  keys = {
    { "<leader>tm", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle markdown rendering" },
  },
  opts = {
    enabled = true,

    -- Render headings with distinct visual levels
    heading = {
      enabled = true,
      sign = true,
      icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
    },

    -- Render code blocks with a distinct background
    code = {
      enabled = true,
      sign = false,
      style = "full",
      border = "thin",
    },

    -- Render bullet list items
    bullet = {
      enabled = true,
      icons = { "●", "○", "◆", "◇" },
    },

    -- Render checkboxes
    checkbox = {
      enabled = true,
      unchecked = { icon = "󰄱 " },
      checked = { icon = "󰱒 " },
    },

    -- Render tables with box-drawing chars
    pipe_table = {
      enabled = true,
      style = "full",
    },

    -- Render block quotes
    quote = {
      enabled = true,
      icon = "▋",
    },

    -- Render horizontal rules
    dash = {
      enabled = true,
      icon = "─",
      width = "full",
    },
  },
}
