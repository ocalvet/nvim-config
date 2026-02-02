return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text",
    "mfussenegger/nvim-dap-python",
    "leoluz/nvim-dap-go",
    "nvim-telescope/telescope-dap.nvim",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    -- DAP UI setup
    dapui.setup({
      icons = { expanded = "▾", collapsed = "▸" },
      mappings = {
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
      },
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.25 },
            { id = "breakpoints", size = 0.25 },
            { id = "stacks", size = 0.25 },
            { id = "watches", size = 0.25 },
          },
          size = 40,
          position = "left",
        },
        {
          elements = {
            { id = "repl", size = 0.5 },
            { id = "console", size = 0.5 },
          },
          size = 10,
          position = "bottom",
        },
      },
    })

    -- Virtual text setup
    require("nvim-dap-virtual-text").setup({
      enabled = true,
      enabled_commands = true,
      highlight_changed_variables = true,
      highlight_new_as_changed = false,
      show_stop_reason = true,
      commented = false,
      only_first_definition = true,
      all_references = false,
      virt_text_pos = "eol",
      all_frames = false,
      virt_lines = false,
    })

    -- Python DAP setup
    require("dap-python").setup("python")
    require("dap-python").test_runner = "pytest"

    -- Go DAP setup
    require("dap-go").setup()

    -- JavaScript/TypeScript DAP setup
    dap.adapters.node2 = {
      type = "executable",
      command = "node",
      args = { vim.fn.stdpath("data") .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js" },
    }

    dap.configurations.javascript = {
      {
        name = "Launch",
        type = "node2",
        request = "launch",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        console = "integratedTerminal",
      },
      {
        name = "Attach to process",
        type = "node2",
        request = "attach",
        processId = require("dap.utils").pick_process,
      },
    }

    dap.configurations.typescript = dap.configurations.javascript
    dap.configurations.javascriptreact = dap.configurations.javascript
    dap.configurations.typescriptreact = dap.configurations.javascript

    -- Auto open/close DAP UI
    dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
    dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
    dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

    -- DAP signs
    vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
    vim.fn.sign_define("DapBreakpointCondition", { text = "●", texthl = "DiagnosticWarn" })
    vim.fn.sign_define("DapLogPoint", { text = "●", texthl = "DiagnosticInfo" })
    vim.fn.sign_define("DapStopped", { text = "→", texthl = "DiagnosticOk", linehl = "DapStoppedLine" })
    vim.fn.sign_define("DapBreakpointRejected", { text = "●", texthl = "DiagnosticHint" })

    -- Keybindings
    vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Continue" })
    vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
    vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
    vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })

    vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
    vim.keymap.set("n", "<leader>dB", function()
      dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end, { desc = "Conditional breakpoint" })
    vim.keymap.set("n", "<leader>lp", function()
      dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
    end, { desc = "Log point" })

    vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle debug UI" })
    vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Open REPL" })
    vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Run last" })

    vim.keymap.set({ "n", "v" }, "<leader>dh", function()
      require("dap.ui.widgets").hover()
    end, { desc = "Debug hover" })
    vim.keymap.set({ "n", "v" }, "<leader>dp", function()
      require("dap.ui.widgets").preview()
    end, { desc = "Debug preview" })
    vim.keymap.set("n", "<leader>df", function()
      local widgets = require("dap.ui.widgets")
      widgets.centered_float(widgets.frames)
    end, { desc = "Debug frames" })
    vim.keymap.set("n", "<leader>ds", function()
      local widgets = require("dap.ui.widgets")
      widgets.centered_float(widgets.scopes)
    end, { desc = "Debug scopes" })

    -- Telescope DAP integration
    vim.keymap.set("n", "<leader>dcc", function()
      require("telescope").extensions.dap.commands({})
    end, { desc = "DAP commands" })
    vim.keymap.set("n", "<leader>dco", function()
      require("telescope").extensions.dap.configurations({})
    end, { desc = "DAP configurations" })
    vim.keymap.set("n", "<leader>dlb", function()
      require("telescope").extensions.dap.list_breakpoints({})
    end, { desc = "List breakpoints" })
    vim.keymap.set("n", "<leader>dv", function()
      require("telescope").extensions.dap.variables({})
    end, { desc = "DAP variables" })
  end,
}
