return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-python",
    "nvim-neotest/neotest-jest",
    "nvim-neotest/neotest-go",
  },
  config = function()
    local neotest = require("neotest")

    neotest.setup({
      adapters = {
        require("neotest-python")({
          dap = { justMyCode = false },
          args = { "--log-level", "DEBUG" },
          runner = "pytest",
          python = "python",
          pytest_discover_instances = true,
        }),
        require("neotest-jest")({
          jestCommand = "npm test --",
          jestConfigFile = "jest.config.js",
          env = { CI = true },
          cwd = function()
            return vim.fn.getcwd()
          end,
        }),
        require("neotest-go")({
          experimental = { test_table = true },
          args = { "-count=1", "-timeout=60s" },
        }),
      },
      discovery = { concurrent = 1, enabled = true },
      running = { concurrent = true },
      summary = {
        enabled = true,
        animated = true,
        follow = true,
        expand_errors = true,
        open = "botright vsplit | vertical resize 50",
      },
      output = { enabled = true, open_on_run = "short" },
      output_panel = { enabled = true, open = "botright split | resize 15" },
      quickfix = { enabled = true, open = false },
      status = { enabled = true, signs = true, virtual_text = false },
      floating = { border = "rounded", max_height = 0.6, max_width = 0.6 },
      icons = {
        child_indent = "│",
        child_prefix = "├",
        collapsed = "─",
        expanded = "╮",
        failed = "✖",
        final_child_indent = " ",
        final_child_prefix = "╰",
        non_collapsible = "─",
        passed = "✓",
        running = "⟳",
        skipped = "○",
        unknown = "?",
        watching = "👁",
      },
    })

    -- Test signs
    vim.fn.sign_define("neotest_passed", { text = "✓", texthl = "NeotestPassed" })
    vim.fn.sign_define("neotest_failed", { text = "✖", texthl = "NeotestFailed" })
    vim.fn.sign_define("neotest_running", { text = "⟳", texthl = "NeotestRunning" })
    vim.fn.sign_define("neotest_skipped", { text = "○", texthl = "NeotestSkipped" })
    vim.fn.sign_define("neotest_unknown", { text = "?", texthl = "NeotestUnknown" })

    -- Keybindings
    vim.keymap.set("n", "<leader>tr", function() neotest.run.run() end, { desc = "Run nearest test" })
    vim.keymap.set("n", "<leader>tf", function() neotest.run.run(vim.fn.expand("%")) end, { desc = "Run file tests" })
    vim.keymap.set("n", "<leader>td", function() neotest.run.run({ strategy = "dap" }) end, { desc = "Debug test" })
    vim.keymap.set("n", "<leader>ts", function() neotest.run.stop() end, { desc = "Stop test" })
    vim.keymap.set("n", "<leader>ta", function() neotest.run.attach() end, { desc = "Attach to test" })
    vim.keymap.set("n", "<leader>to", function() neotest.output.open({ enter = true, auto_close = true }) end, { desc = "Test output" })
    vim.keymap.set("n", "<leader>tO", function() neotest.output_panel.toggle() end, { desc = "Toggle output panel" })
    vim.keymap.set("n", "<leader>tt", function() neotest.summary.toggle() end, { desc = "Toggle summary" })
    vim.keymap.set("n", "[t", function() neotest.jump.prev({ status = "failed" }) end, { desc = "Previous failed test" })
    vim.keymap.set("n", "]t", function() neotest.jump.next({ status = "failed" }) end, { desc = "Next failed test" })
    vim.keymap.set("n", "<leader>tw", function() neotest.watch.toggle(vim.fn.expand("%")) end, { desc = "Watch tests" })
  end,
}
