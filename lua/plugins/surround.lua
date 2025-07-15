return {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            keymaps = {
                insert = "<C-g>s",
                insert_line = "<C-g>S",
                normal = "ys",
                normal_cur = "yss",
                normal_line = "yS",
                normal_cur_line = "ySS",
                visual = "S",
                visual_line = "gS",
                delete = "ds",
                change = "cs",
                change_line = "cS",
            },
            surrounds = {
                -- Custom surrounds for React/JSX
                ["t"] = {
                    add = function()
                        local config = require("nvim-surround.config")
                        local result = config.get_input("Enter the tag name: ")
                        if result then
                            return { { "<" .. result .. ">" }, { "</" .. result .. ">" } }
                        end
                    end,
                    find = "<[^>]*>.-</[^>]*>",
                    delete = "^(<[^>]*>)().*(</[^>]*>)()$",
                    change = {
                        target = "^<([^>]*)().-</([^>]*)()>$",
                        replacement = function()
                            local config = require("nvim-surround.config")
                            local result = config.get_input("Enter the new tag name: ")
                            if result then
                                return { { "<" .. result .. ">" }, { "</" .. result .. ">" } }
                            end
                        end,
                    },
                },
                -- Custom surround for JSX fragments
                ["f"] = {
                    add = { "<>", "</>" },
                    find = "<>.-</>",
                    delete = "^(<>)().*(</> )()$",
                },
                -- Custom surround for JSX expressions
                ["{"] = {
                    add = { "{ ", " }" },
                    find = "%b{}",
                    delete = "^({ )().-( })()$",
                },
                -- Custom surround for template literals
                ["`"] = {
                    add = { "`", "`" },
                    find = "`.-`",
                    delete = "^(`)().-(`)()$",
                },
                -- Custom surround for console.log
                ["l"] = {
                    add = function()
                        return { { "console.log(" }, { ")" } }
                    end,
                    find = "console%.log%b()",
                    delete = "^(console%.log%()().-(%))()$",
                },
                -- Custom surround for Python f-strings
                ["F"] = {
                    add = { 'f"', '"' },
                    find = 'f".-"',
                    delete = '^(f")()(.-)(")()$',
                },
            },
            aliases = {
                ["a"] = ">", -- Single character aliases apply everywhere
                ["b"] = ")",
                ["B"] = "}",
                ["r"] = "]",
                ["q"] = { '"', "'", "`" },
                ["s"] = { "}", "]", ")", ">", '"', "'", "`" },
            },
            highlight = {
                duration = 200,
            },
            move_cursor = "begin",
            indent_lines = function(start, stop)
                local b = vim.bo
                -- Only re-indent the selection if a formatter is set up already
                if start < stop and (b.autoindent or b.smartindent or b.cindent) then
                    vim.cmd(string.format("silent normal! %dGV%dG=", start, stop))
                end
            end,
        })
    end,
}