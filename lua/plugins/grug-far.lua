return {
  "MagicDuck/grug-far.nvim",
  keys = {
    {
      "<leader>sr",
      function()
        require("grug-far").open()
      end,
      desc = "Search & Replace (project-wide)",
    },
    {
      "<leader>sR",
      function()
        -- Open with the word under cursor pre-filled
        require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
      end,
      desc = "Search & Replace (cursor word)",
    },
    {
      "<leader>sr",
      function()
        -- Open with the visual selection pre-filled
        require("grug-far").with_visual_selection()
      end,
      mode = "v",
      desc = "Search & Replace (selection)",
    },
  },
  opts = {
    -- Use ripgrep for fast searching
    engine = "ripgrep",
    -- Keymaps within the grug-far buffer
    keymaps = {
      replace = { n = "<leader>r" },
      qflist = { n = "<leader>q" },
      syncLocations = { n = "<leader>s" },
      syncLine = { n = "<leader>l" },
      close = { n = "<leader>c" },
      historyOpen = { n = "<leader>h" },
      historyAdd = { n = "<leader>H" },
      refresh = { n = "<leader>f" },
      openLocation = { n = "<leader>o" },
      abort = { n = "<leader>a" },
      toggleShowCommand = { n = "<leader>p" },
      swapEngine = { n = "<leader>e" },
    },
    -- Start with a reasonable window width
    windowCreationCommand = "vsplit",
  },
}
