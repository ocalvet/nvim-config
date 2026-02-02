-- Lua development support for Neovim config editing
-- Provides completion and type hints for Neovim Lua API
return {
  "folke/lazydev.nvim",
  ft = "lua",
  opts = {
    library = {
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
  },
}
