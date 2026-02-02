return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local which_key = require("which-key")

    which_key.setup({
      plugins = {
        marks = true,
        registers = true,
        spelling = {
          enabled = true,
          suggestions = 20,
        },
        presets = {
          operators = true,
          motions = true,
          text_objects = true,
          windows = true,
          nav = true,
          z = true,
          g = true,
        },
      },
      win = {
        border = "rounded",
        padding = { 2, 2, 2, 2 },
        wo = {
          winblend = 0,
        },
      },
      layout = {
        height = { min = 4, max = 25 },
        width = { min = 20, max = 50 },
        spacing = 3,
        align = "left",
      },
      filter = function(mapping)
        -- Filter out mappings that should be hidden
        return not vim.tbl_contains({ "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, mapping.desc)
      end,
      show = {
        help = true,
        keys = true,
      },
      triggers = {
        { "<auto>", mode = "nxso" },
      },
      defer = function(ctx)
        return ctx.mode == "v" or ctx.mode == "V"
      end,
    })

    -- Define key mappings with descriptions
    which_key.add({
      -- Search operations
      { "<leader>s", group = "Search" },
      { "<leader>sf", desc = "Find Files" },
      { "<leader>sg", desc = "Live Grep" },
      { "<leader>sb", desc = "Find Buffers" },
      { "<leader>sh", desc = "Help Tags" },
      { "<leader>sw", desc = "Search Word" },
      { "<leader>sd", desc = "Diagnostics" },
      { "<leader>sr", desc = "Resume Search" },
      { "<leader>s.", desc = "Recent Files" },
      { "<leader>s/", desc = "Search in Open Files" },
      { "<leader>sk", desc = "Keymaps" },
      { "<leader>ss", desc = "Select Telescope" },

      -- File explorer
      { "<leader>e", desc = "Toggle File Explorer" },
      { "<leader>n", group = "Neo-tree" },
      { "<leader>ngs", desc = "Git Status" },

      -- Buffer operations
      { "<leader>b", desc = "New Buffer" },

      -- Window management
      { "<leader>w", group = "Window" },
      { "<leader>wv", desc = "Split Vertical" },
      { "<leader>ws", desc = "Split Horizontal" },
      { "<leader>we", desc = "Equal Splits" },
      { "<leader>wx", desc = "Close Split" },

      -- Git operations
      { "<leader>g", group = "Git" },
      { "<leader>gg", desc = "Neogit Status" },
      { "<leader>gc", desc = "Neogit Commit" },
      { "<leader>gP", desc = "Neogit Push" },
      { "<leader>gp", desc = "Neogit Pull" },
      { "<leader>gb", desc = "Neogit Branch" },
      { "<leader>gd", desc = "Diffview Open" },
      { "<leader>gD", desc = "Diffview Open HEAD~1" },
      { "<leader>gh", desc = "Diffview File History" },
      { "<leader>gH", desc = "Diffview Current File History" },
      { "<leader>gx", desc = "Diffview Close" },

      -- Hunk operations
      { "<leader>h", group = "Hunk" },
      { "<leader>hs", desc = "Stage Hunk" },
      { "<leader>hr", desc = "Reset Hunk" },
      { "<leader>hS", desc = "Stage Buffer" },
      { "<leader>hR", desc = "Reset Buffer" },
      { "<leader>hu", desc = "Undo Stage Hunk" },
      { "<leader>hp", desc = "Preview Hunk" },
      { "<leader>hb", desc = "Blame Line" },
      { "<leader>hB", desc = "Toggle Line Blame" },
      { "<leader>hd", desc = "Diff This" },
      { "<leader>hD", desc = "Diff This ~" },

      -- Trouble operations
      { "<leader>x", group = "Trouble" },
      { "<leader>xx", desc = "Toggle Trouble" },
      { "<leader>xw", desc = "Workspace Diagnostics" },
      { "<leader>xd", desc = "Document Diagnostics" },
      { "<leader>xl", desc = "Location List" },
      { "<leader>xq", desc = "Quickfix List" },
      { "<leader>xr", desc = "LSP References" },

      -- Tab management
      { "<leader>t", group = "Tabs/Tests" },
      { "<leader>tO", desc = "Open Tab" },
      { "<leader>tx", desc = "Close Tab" },
      { "<leader>tn", desc = "Next Tab" },
      { "<leader>tp", desc = "Previous Tab" },

      -- Testing
      { "<leader>tr", desc = "Run Test" },
      { "<leader>tf", desc = "Run File Tests" },
      { "<leader>td", desc = "Debug Test" },
      { "<leader>ts", desc = "Stop Test" },
      { "<leader>ta", desc = "Attach Test" },
      { "<leader>to", desc = "Test Output" },
      { "<leader>tP", desc = "Test Output Panel" },
      { "<leader>tt", desc = "Test Summary" },
      { "<leader>tw", desc = "Watch Tests" },

      -- Debugging
      { "<leader>d", group = "Debug" },
      { "<leader>db", desc = "Toggle Breakpoint" },
      { "<leader>dB", desc = "Conditional Breakpoint" },
      { "<leader>du", desc = "Debug UI" },
      { "<leader>dr", desc = "Debug REPL" },
      { "<leader>dl", desc = "Debug Last" },
      { "<leader>dh", desc = "Debug Hover" },
      { "<leader>dp", desc = "Debug Preview" },
      { "<leader>df", desc = "Debug Frames" },
      { "<leader>dS", desc = "Debug Scopes" },
      { "<leader>dc", group = "Debug Commands" },
      { "<leader>dcc", desc = "Commands" },
      { "<leader>dco", desc = "Configurations" },
      { "<leader>dlb", desc = "List Breakpoints" },
      { "<leader>dv", desc = "Variables" },

      -- LSP
      { "<leader>D", desc = "Type Definition" },
      { "<leader>rn", desc = "Rename" },
      { "<leader>ca", desc = "Code Action" },
      { "<leader>q", desc = "Diagnostics List" },
      { "<leader>th", desc = "Toggle Inlay Hints" },

      -- LSP symbols
      { "<leader>fws", desc = "Workspace Symbols" },

      -- Misc
      { "<leader>lw", desc = "Toggle Line Wrap" },
      { "<leader>sn", desc = "Save No Format" },
      { "<leader>/", desc = "Search in Buffer" },
      { "<leader><leader>", desc = "Find Buffers" },
      { "<leader>lp", desc = "Log Point" },

      -- Function keys
      { "<F5>", desc = "Continue Debug" },
      { "<F10>", desc = "Step Over" },
      { "<F11>", desc = "Step Into" },
      { "<F12>", desc = "Step Out" },

      -- Navigation
      { "[d", desc = "Previous Diagnostic" },
      { "]d", desc = "Next Diagnostic" },
      { "[t", desc = "Previous Failed Test" },
      { "]t", desc = "Next Failed Test" },
      { "[h", desc = "Previous Hunk" },
      { "]h", desc = "Next Hunk" },
      { "gd", desc = "Go to Definition" },
      { "gr", desc = "Go to References" },
      { "gI", desc = "Go to Implementation" },
      { "gD", desc = "Go to Declaration" },

      -- Flash motion
      { "s", desc = "Flash Jump" },
      { "S", desc = "Flash Treesitter" },
      { "r", desc = "Remote Flash", mode = "o" },
      { "R", desc = "Treesitter Search", mode = { "o", "x" } },

      -- Visual mode
      { "<leader>d", desc = "Debug", mode = "v" },
      { "<leader>dh", desc = "Debug Hover", mode = "v" },
      { "<leader>dp", desc = "Debug Preview", mode = "v" },
      { "<leader>hs", desc = "Stage Hunk", mode = "v" },
      { "<leader>hr", desc = "Reset Hunk", mode = "v" },
    })
  end,
}
