return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    -- Labels appear on the first character of the match
    labels = "asdfghjklqwertyuiopzxcvbnm",
    modes = {
      -- Enable flash for search (/) and (?)
      search = { enabled = true },
      -- Enable flash for f, F, t, T motions
      char = { enabled = true },
    },
  },
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
  },
}
