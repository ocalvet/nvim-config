-- Terminal integration using snacks (already a dependency)
-- - <C-\> toggles an interactive bottom shell
-- - :! command   is rerouted to run in a bottom terminal so output stays visible
return {
  {
    "folke/snacks.nvim",
    opts = {
      terminal = {
        win = {
          position = "bottom",
          height = 0.30,
        },
      },
    },
    keys = {
      {
        "<c-\\>",
        function()
          Snacks.terminal.toggle()
        end,
        desc = "Toggle Terminal",
      },
      {
        "<leader>\\",
        function()
          Snacks.terminal.toggle()
        end,
        desc = "Toggle Terminal",
      },
    },
    config = function()
      local last_cmd = nil

      -- User command for running shell commands in the terminal
      vim.api.nvim_create_user_command("Bang", function(opts)
        local cmd = vim.trim(opts.args or "")

        if cmd == "" or cmd == "!" then
          if last_cmd then
            cmd = last_cmd
          else
            cmd = vim.fn.input(":! ", "", "shellcmd")
            if cmd == "" then
              return
            end
          end
        end

        cmd = vim.fn.expandcmd(cmd)
        last_cmd = cmd

        Snacks.terminal(cmd, {
          interactive = false,
          auto_close = false,
          win = {
            position = "bottom",
          },
        })
      end, {
        nargs = "*",
        complete = "shellcmd",
        desc = "Run :! command in snacks terminal (output stays visible)",
      })

      -- Only turn a *leading* `!` at the start of a command line into our Bang command.
      -- This keeps filter usage like `:w !cmd`, `:%!sort`, `:r !cmd` working natively.
      vim.cmd([[
        cnoreabbrev <expr> !  (getcmdtype() == ':' && getcmdpos() <= 2) ? 'Bang' : '!'
        cnoreabbrev <expr> !! (getcmdtype() == ':' && getcmdline() =~# '^!!$') ? 'Bang !' : '!!'
      ]])
    end,
  },
}
