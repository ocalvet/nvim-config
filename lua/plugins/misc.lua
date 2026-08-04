-- Standalone plugins with minimal config
return {
  {
    -- Tmux & split window navigation
    -- Note: <C-\> is intentionally omitted (we use it for terminal toggle)
    "christoomey/vim-tmux-navigator",
    event = "VeryLazy",
    init = function()
      -- Prevent the plugin from creating its default mappings (including <C-\>)
      vim.g.tmux_navigator_no_mappings = 1
    end,
    config = function()
      -- Define mappings here (after no_mappings) so they are always available
      vim.keymap.set({ "n", "t" }, "<c-h>", "<cmd>TmuxNavigateLeft<cr>")
      vim.keymap.set({ "n", "t" }, "<c-j>", "<cmd>TmuxNavigateDown<cr>")
      vim.keymap.set({ "n", "t" }, "<c-k>", "<cmd>TmuxNavigateUp<cr>")
      vim.keymap.set({ "n", "t" }, "<c-l>", "<cmd>TmuxNavigateRight<cr>")
    end,
  },
  {
    -- Detect tabstop and shiftwidth automatically
    "tpope/vim-sleuth",
  },
  {
    -- Powerful Git integration for Vim
    "tpope/vim-fugitive",
  },
  {
    -- GitHub integration for vim-fugitive
    "tpope/vim-rhubarb",
  },
  {
    -- Autoclose parentheses, brackets, quotes, etc.
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
    opts = {},
  },
  {
    -- Highlight todo, notes, etc in comments
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
  },
  {
    -- Python virtualenv discovery and switching
    "linux-cultist/venv-selector.nvim",
    ft = "python",
    cmd = { "VenvSelect", "VenvSelectCache", "VenvSelectLog" },
    keys = {
      { "<leader>tv", "<cmd>VenvSelect<CR>", desc = "Select Python environment" },
    },
    opts = {
      options = {
        fd_binary_name = vim.fn.executable("fdfind") == 1 and "fdfind" or "fd",
        cached_venv_automatic_activation = true,
        activate_venv_in_terminal = true,
        set_environment_variables = true,
      },
    },
  },
  {
    -- High-performance color highlighter (maintained fork of norcalli/nvim-colorizer.lua)
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPre",
    config = function()
      require("colorizer").setup()
    end,
  },
}
