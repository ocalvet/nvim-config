return {
  {
    -- snacks.nvim must load early (priority = 1000) — we use only the notifier
    -- module here. Other snacks modules (dashboard, picker, etc.) are disabled
    -- so they don't conflict with alpha, telescope, neo-tree.
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      notifier = {
        enabled = true,
        timeout = 4000,
        width = { min = 40, max = 80 },
        height = { min = 1, max = 20 }, -- allow real multiline messages
        style = "fancy",                -- "fancy" | "compact" | "minimal"
        top_down = false,               -- notifications stack from bottom-right up
        margin = { top = 0, right = 1, bottom = 1 },
        icons = {
          error   = " ",
          warn    = " ",
          info    = " ",
          debug   = " ",
          trace   = "✎ ",
        },
      },
      -- disable every other snacks module explicitly
      bigfile    = { enabled = false },
      dashboard  = { enabled = false },
      indent     = { enabled = false },
      input      = { enabled = false },
      picker     = { enabled = false },
      quickfile  = { enabled = false },
      scroll     = { enabled = false },
      statuscolumn = { enabled = false },
      words      = { enabled = false },
    },
    keys = {
      {
        "<leader>sN",
        function() Snacks.notifier.show_history() end,
        desc = "Notification history",
      },
      {
        "<leader>un",
        function() Snacks.notifier.hide() end,
        desc = "Dismiss all notifications",
      },
    },
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "folke/snacks.nvim",   -- snacks replaces nvim-notify as the notification backend
    },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = true,  -- border on hover docs looks better with snacks
      },
      -- Route all vim.notify calls through snacks.notifier
      routes = {
        {
          -- Send large/multiline messages to a split instead of a popup
          filter = { event = "msg_show", min_height = 10 },
          view = "split",
        },
        {
          -- Skip noisy "written" messages
          filter = {
            event = "msg_show",
            kind = "",
            find = "written",
          },
          opts = { skip = true },
        },
      },
    },
    config = function(_, opts)
      require("noice").setup(opts)

      -- Route vim.notify through snacks so all notifications are multiline-aware
      vim.notify = function(msg, level, o)
        Snacks.notify(msg, vim.tbl_extend("force", o or {}, {
          level = level,
        }))
      end
    end,
  },
}
