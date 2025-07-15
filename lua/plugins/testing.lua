return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        -- Test adapters
        "nvim-neotest/neotest-python",
        "nvim-neotest/neotest-jest",
        "nvim-neotest/neotest-go",
    },
    config = function()
        local neotest = require("neotest")
        
        neotest.setup({
            adapters = {
                -- Python testing
                require("neotest-python")({
                    dap = { justMyCode = false },
                    args = { "--log-level", "DEBUG" },
                    runner = "pytest",
                    python = "python",
                    pytest_discover_instances = true,
                }),
                
                -- JavaScript/TypeScript testing with Jest
                require("neotest-jest")({
                    jestCommand = "npm test --",
                    jestConfigFile = "jest.config.js",
                    env = { CI = true },
                    cwd = function()
                        return vim.fn.getcwd()
                    end,
                }),
                
                -- Go testing
                require("neotest-go")({
                    experimental = {
                        test_table = true,
                    },
                    args = { "-count=1", "-timeout=60s" },
                }),
            },
            
            -- Discovery settings
            discovery = {
                concurrent = 1,
                enabled = true,
            },
            
            -- Running settings
            running = {
                concurrent = true,
            },
            
            -- Summary window settings
            summary = {
                enabled = true,
                animated = true,
                follow = true,
                expand_errors = true,
                open = "botright vsplit | vertical resize 50",
                mappings = {
                    attach = "a",
                    clear_marked = "M",
                    clear_target = "T",
                    debug = "d",
                    debug_marked = "D",
                    expand = { "<CR>", "<2-LeftMouse>" },
                    expand_all = "e",
                    jumpto = "i",
                    mark = "m",
                    next_failed = "J",
                    output = "o",
                    prev_failed = "K",
                    run = "r",
                    run_marked = "R",
                    short = "O",
                    stop = "u",
                    target = "t",
                    watch = "w",
                },
            },
            
            -- Output settings
            output = {
                enabled = true,
                open_on_run = "short",
            },
            
            -- Output panel settings
            output_panel = {
                enabled = true,
                open = "botright split | resize 15",
            },
            
            -- Quickfix settings
            quickfix = {
                enabled = true,
                open = false,
            },
            
            -- Status settings
            status = {
                enabled = true,
                signs = true,
                virtual_text = false,
            },
            
            -- Strategies
            strategies = {
                integrated = {
                    height = 40,
                    width = 120,
                },
            },
            
            -- Icons
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
                running_animated = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
                skipped = "○",
                unknown = "?",
                watching = "👁",
            },
            
            -- Floating window settings
            floating = {
                border = "rounded",
                max_height = 0.6,
                max_width = 0.6,
                options = {},
            },
            
            -- Highlights
            highlights = {
                adapter_name = "NeotestAdapterName",
                border = "NeotestBorder",
                dir = "NeotestDir",
                expand_marker = "NeotestExpandMarker",
                failed = "NeotestFailed",
                file = "NeotestFile",
                focused = "NeotestFocused",
                indent = "NeotestIndent",
                marked = "NeotestMarked",
                namespace = "NeotestNamespace",
                passed = "NeotestPassed",
                running = "NeotestRunning",
                select_win = "NeotestWinSelect",
                skipped = "NeotestSkipped",
                target = "NeotestTarget",
                test = "NeotestTest",
                unknown = "NeotestUnknown",
                watching = "NeotestWatching",
            },
        })
        
        -- Test signs
        vim.fn.sign_define("neotest_passed", { text = "✓", texthl = "NeotestPassed" })
        vim.fn.sign_define("neotest_failed", { text = "✖", texthl = "NeotestFailed" })
        vim.fn.sign_define("neotest_running", { text = "⟳", texthl = "NeotestRunning" })
        vim.fn.sign_define("neotest_skipped", { text = "○", texthl = "NeotestSkipped" })
        vim.fn.sign_define("neotest_unknown", { text = "?", texthl = "NeotestUnknown" })
        
        -- Keybindings
        local opts = { noremap = true, silent = true }
        
        -- Run tests
        vim.keymap.set("n", "<leader>tr", function()
            neotest.run.run()
        end, opts)
        
        vim.keymap.set("n", "<leader>tf", function()
            neotest.run.run(vim.fn.expand("%"))
        end, opts)
        
        vim.keymap.set("n", "<leader>td", function()
            neotest.run.run({ strategy = "dap" })
        end, opts)
        
        vim.keymap.set("n", "<leader>ts", function()
            neotest.run.stop()
        end, opts)
        
        vim.keymap.set("n", "<leader>ta", function()
            neotest.run.attach()
        end, opts)
        
        -- Test output
        vim.keymap.set("n", "<leader>to", function()
            neotest.output.open({ enter = true, auto_close = true })
        end, opts)
        
        vim.keymap.set("n", "<leader>tO", function()
            neotest.output_panel.toggle()
        end, opts)
        
        -- Test summary
        vim.keymap.set("n", "<leader>tt", function()
            neotest.summary.toggle()
        end, opts)
        
        -- Navigation
        vim.keymap.set("n", "[t", function()
            neotest.jump.prev({ status = "failed" })
        end, opts)
        
        vim.keymap.set("n", "]t", function()
            neotest.jump.next({ status = "failed" })
        end, opts)
        
        -- Watch mode
        vim.keymap.set("n", "<leader>tw", function()
            neotest.watch.toggle(vim.fn.expand("%"))
        end, opts)
    end,
}