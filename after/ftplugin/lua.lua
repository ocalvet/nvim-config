-- Override for Lua files to prevent treesitter errors on Neovim dev builds
-- This runs after the default ftplugin/lua.lua

local nvim_version = vim.version()
if nvim_version.prerelease then
  -- Disable treesitter for this buffer on dev builds
  vim.b.ts_highlight = false
  
  -- Use traditional syntax highlighting instead
  vim.cmd("syntax on")
end
