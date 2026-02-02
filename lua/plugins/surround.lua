return {
  "kylechui/nvim-surround",
  version = "*",
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
        -- Custom surround for HTML/JSX tags
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
        -- JSX fragments
        ["f"] = {
          add = { "<>", "</>" },
          find = "<>.-</>",
          delete = "^(<>)().*(</> )()$",
        },
        -- JSX expressions
        ["{"] = {
          add = { "{ ", " }" },
          find = "%b{}",
          delete = "^({ )().-( })()$",
        },
        -- Template literals
        ["`"] = {
          add = { "`", "`" },
          find = "`.-`",
          delete = "^(`)().-(`)()$",
        },
        -- console.log wrapper
        ["l"] = {
          add = function()
            return { { "console.log(" }, { ")" } }
          end,
          find = "console%.log%b()",
          delete = "^(console%.log%()().-(%))()$",
        },
        -- Python f-strings
        ["F"] = {
          add = { 'f"', '"' },
          find = 'f".-"',
          delete = '^(f")()(.-)(")()$',
        },
      },
      aliases = {
        ["a"] = ">",
        ["b"] = ")",
        ["B"] = "}",
        ["r"] = "]",
        ["q"] = { '"', "'", "`" },
        ["s"] = { "}", "]", ")", ">", '"', "'", "`" },
      },
      highlight = { duration = 200 },
      move_cursor = "begin",
      indent_lines = function(start, stop)
        local b = vim.bo
        if start < stop and (b.autoindent or b.smartindent or b.cindent) then
          vim.cmd(string.format("silent normal! %dGV%dG=", start, stop))
        end
      end,
    })
  end,
}
