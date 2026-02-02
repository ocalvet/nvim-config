return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    -- Setup treesitter with default install directory
    require("nvim-treesitter").setup({})

    -- Install common parsers asynchronously
    local parsers = {
      "lua",
      "vim",
      "vimdoc",
      "bash",
      "python",
      "javascript",
      "typescript",
      "tsx",
      "json",
      "yaml",
      "markdown",
    }

    -- Install parsers in the background (non-blocking)
    require("nvim-treesitter").install(parsers)
  end,
}
