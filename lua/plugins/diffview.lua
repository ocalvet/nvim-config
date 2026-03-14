return {
  "sindrets/diffview.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
  config = function()
    local actions = require("diffview.actions")

    require("diffview").setup({
      -- Only non-default settings are listed here; see :h diffview-config for all options
      view = {
        merge_tool = {
          layout = "diff3_horizontal",
          disable_diagnostics = true,
          winbar_info = true,
        },
      },

      file_panel = {
        tree_options = {
          flatten_dirs = true,
          folder_statuses = "only_folded",
        },
        win_config = {
          position = "left",
          width = 35,
        },
      },

      file_history_panel = {
        log_options = {
          git = {
            single_file = { diff_merges = "combined" },
            multi_file = { diff_merges = "first-parent" },
          },
        },
        win_config = {
          position = "bottom",
          height = 16,
        },
      },

      -- Override only the keymaps that differ from defaults
      keymaps = {
        disable_defaults = false,
        view = {
          { "n", "[x", actions.prev_conflict, { desc = "Previous conflict" } },
          { "n", "]x", actions.next_conflict, { desc = "Next conflict" } },
          { "n", "<leader>co", actions.conflict_choose("ours"), { desc = "Choose OURS" } },
          { "n", "<leader>ct", actions.conflict_choose("theirs"), { desc = "Choose THEIRS" } },
          { "n", "<leader>cb", actions.conflict_choose("base"), { desc = "Choose BASE" } },
          { "n", "<leader>ca", actions.conflict_choose("all"), { desc = "Choose all" } },
          { "n", "dx", actions.conflict_choose("none"), { desc = "Delete conflict region" } },
        },
      },
    })

    local opts = { noremap = true, silent = true }

    vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<CR>", vim.tbl_extend("force", opts, { desc = "Diffview open" }))
    vim.keymap.set("n", "<leader>gD", "<cmd>DiffviewOpen HEAD~1<CR>", vim.tbl_extend("force", opts, { desc = "Diffview open HEAD~1" }))
    vim.keymap.set("n", "<leader>gh", "<cmd>DiffviewFileHistory<CR>", vim.tbl_extend("force", opts, { desc = "Diffview file history" }))
    vim.keymap.set("n", "<leader>gH", "<cmd>DiffviewFileHistory %<CR>", vim.tbl_extend("force", opts, { desc = "Diffview current file history" }))
    vim.keymap.set("n", "<leader>gx", "<cmd>DiffviewClose<CR>", vim.tbl_extend("force", opts, { desc = "Diffview close" }))
    vim.keymap.set("n", "<leader>gr", "<cmd>DiffviewRefresh<CR>", vim.tbl_extend("force", opts, { desc = "Diffview refresh" }))
    vim.keymap.set("n", "<leader>gf", "<cmd>DiffviewFocusFiles<CR>", vim.tbl_extend("force", opts, { desc = "Diffview focus files" }))
    vim.keymap.set("n", "<leader>gt", "<cmd>DiffviewToggleFiles<CR>", vim.tbl_extend("force", opts, { desc = "Diffview toggle files" }))
  end,
}
