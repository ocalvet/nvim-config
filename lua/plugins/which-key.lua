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
            window = {
                border = "rounded",
                position = "bottom",
                margin = { 1, 0, 1, 0 },
                padding = { 2, 2, 2, 2 },
                winblend = 0,
            },
            layout = {
                height = { min = 4, max = 25 },
                width = { min = 20, max = 50 },
                spacing = 3,
                align = "left",
            },
            ignore_missing = true,
            hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
            show_help = true,
            show_keys = true,
            triggers = "auto",
            timeout = 1000,
            delay = 0,
        })

        -- Define key mappings with descriptions
        which_key.add({
            -- File operations
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
            { "<leader>x", desc = "Close Buffer" },
            
            -- Window management
            { "<leader>v", desc = "Split Vertical" },
            { "<leader>h", desc = "Split Horizontal" },
            { "<leader>se", desc = "Equal Splits" },
            { "<leader>xs", desc = "Close Split" },
            
            -- Tab management
            { "<leader>t", group = "Tabs/Tests" },
            { "<leader>to", desc = "Open Tab" },
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
            { "<leader>tO", desc = "Test Output Panel" },
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
            { "<leader>ds", desc = "Debug Scopes" },
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
            
            -- Document symbols
            { "<leader>ds", desc = "Document Symbols" },
            { "<leader>ws", desc = "Workspace Symbols" },
            
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
            { "gd", desc = "Go to Definition" },
            { "gr", desc = "Go to References" },
            { "gI", desc = "Go to Implementation" },
            { "gD", desc = "Go to Declaration" },
            
            -- Visual mode
            { "<leader>d", desc = "Debug", mode = "v" },
            { "<leader>dh", desc = "Debug Hover", mode = "v" },
            { "<leader>dp", desc = "Debug Preview", mode = "v" },
        })
    end,
}