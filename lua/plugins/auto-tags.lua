return {
    "windwp/nvim-ts-autotag",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
        require('nvim-ts-autotag').setup({
            opts = {
                -- Defaults
                enable_close = true, -- Auto close tags
                enable_rename = true, -- Auto rename pairs of tags
                enable_close_on_slash = false -- Auto close on trailing </
            },
            -- Also override individual filetype configs, these take priority.
            -- Empty by default, useful if one of the "opts" global settings
            -- doesn't work well in a specific filetype
            per_filetype = {
                ["html"] = {
                    enable_close = true
                },
                ["javascript"] = {
                    enable_close = true
                },
                ["javascriptreact"] = {
                    enable_close = true
                },
                ["typescript"] = {
                    enable_close = true
                },
                ["typescriptreact"] = {
                    enable_close = true
                },
                ["vue"] = {
                    enable_close = true
                },
                ["xml"] = {
                    enable_close = true
                },
                ["php"] = {
                    enable_close = true
                },
                ["markdown"] = {
                    enable_close = true
                },
            }
        })
    end,
}