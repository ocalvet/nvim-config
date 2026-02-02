require("options")
require("keymaps")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    error("Error cloning lazy.nvim:\n" .. out)
  end
end
---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require("lazy").setup({
  -- UI & Appearance
  require("plugins.colortheme"),
  require("plugins.alpha"),
  require("plugins.bufferline"),
  require("plugins.lualine"),
  require("plugins.indent-blankline"),
  require("plugins.noice"),

  -- File Navigation
  require("plugins.neotree"),
  require("plugins.telescope"),
  require("plugins.flash"),

  -- LSP & Completion
  require("plugins.lsp"),
  require("plugins.autocompletion"),
  require("plugins.autoformatting"),
  require("plugins.lazydev"),
  require("plugins.trouble"),

  -- Treesitter
  require("plugins.treesitter"),

  -- Git Integration
  require("plugins.gitsigns"),
  require("plugins.diffview"),
  require("plugins.neogit"),

  -- Debugging & Testing
  require("plugins.dap"),
  require("plugins.testing"),

  -- Editing Enhancements
  require("plugins.auto-tags"),
  require("plugins.surround"),
  require("plugins.which-key"),
  require("plugins.misc"),
}, {
  -- Disable luarocks (not needed, avoids hererocks warnings)
  rocks = {
    enabled = false,
  },
})
