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
            filter_references_pattern = "<module",
            virt_text_pos = "eol",
            all_frames = false,
            virt_lines = false,
            virt_text_win_col = nil,
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

        -- React debugging configuration
        dap.configurations.javascriptreact = {
            {
                name = "Launch React",
                type = "node2",
                request = "launch",
                program = "${workspaceFolder}/node_modules/.bin/react-scripts",
                args = { "start" },
                cwd = "${workspaceFolder}",
                protocol = "inspector",
                console = "integratedTerminal",
                internalConsoleOptions = "neverOpen",
            },
        }

        dap.configurations.typescriptreact = dap.configurations.javascriptreact

        -- Auto open/close DAP UI
        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end

        -- DAP signs
        vim.fn.sign_define("DapBreakpoint", { text = "🟥", texthl = "", linehl = "", numhl = "" })
        vim.fn.sign_define("DapBreakpointCondition", { text = "🟡", texthl = "", linehl = "", numhl = "" })
        vim.fn.sign_define("DapLogPoint", { text = "🟢", texthl = "", linehl = "", numhl = "" })
        vim.fn.sign_define("DapStopped", { text = "➡️", texthl = "", linehl = "", numhl = "" })
        vim.fn.sign_define("DapBreakpointRejected", { text = "❌", texthl = "", linehl = "", numhl = "" })

        -- Keybindings
        local opts = { noremap = true, silent = true }
        
        -- Debug control
        vim.keymap.set("n", "<F5>", dap.continue, opts)
        vim.keymap.set("n", "<F10>", dap.step_over, opts)
        vim.keymap.set("n", "<F11>", dap.step_into, opts)
        vim.keymap.set("n", "<F12>", dap.step_out, opts)
        
        -- Breakpoints
        vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, opts)
        vim.keymap.set("n", "<leader>dB", function()
            dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end, opts)
        vim.keymap.set("n", "<leader>lp", function()
            dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
        end, opts)
        
        -- DAP UI
        vim.keymap.set("n", "<leader>du", dapui.toggle, opts)
        vim.keymap.set("n", "<leader>dr", dap.repl.open, opts)
        vim.keymap.set("n", "<leader>dl", dap.run_last, opts)
        
        -- Variables and evaluation
        vim.keymap.set({"n", "v"}, "<leader>dh", function()
            require("dap.ui.widgets").hover()
        end, opts)
        vim.keymap.set({"n", "v"}, "<leader>dp", function()
            require("dap.ui.widgets").preview()
        end, opts)
        vim.keymap.set("n", "<leader>df", function()
            local widgets = require("dap.ui.widgets")
            widgets.centered_float(widgets.frames)
        end, opts)
        vim.keymap.set("n", "<leader>ds", function()
            local widgets = require("dap.ui.widgets")
            widgets.centered_float(widgets.scopes)
        end, opts)
        
        -- Telescope DAP integration
        vim.keymap.set("n", "<leader>dcc", function()
            require("telescope").extensions.dap.commands({})
        end, opts)
        vim.keymap.set("n", "<leader>dco", function()
            require("telescope").extensions.dap.configurations({})
        end, opts)
        vim.keymap.set("n", "<leader>dlb", function()
            require("telescope").extensions.dap.list_breakpoints({})
        end, opts)
        vim.keymap.set("n", "<leader>dv", function()
            require("telescope").extensions.dap.variables({})
        end, opts)
        vim.keymap.set("n", "<leader>df", function()
            require("telescope").extensions.dap.frames({})
        end, opts)
    end,
}