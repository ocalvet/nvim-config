-- Terminal integration using snacks (already a dependency)
-- - <C-\> or <leader>\ toggles an interactive bottom shell
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
      -- Customize terminal style to make double-Esc more forgiving
      styles = {
        terminal = {
          keys = {
            term_normal = {
              "<esc>",
              function(self)
                self.esc_timer = self.esc_timer or (vim.uv or vim.loop).new_timer()
                if self.esc_timer:is_active() then
                  self.esc_timer:stop()
                  vim.cmd("stopinsert")
                else
                  -- 400ms window makes double-Esc much easier to hit reliably
                  self.esc_timer:start(400, 0, function() end)
                  return "<esc>"
                end
              end,
              mode = "t",
              expr = true,
              desc = "Double escape to normal mode",
            },
            -- Also support double C-[ (common Esc encoding)
            term_normal_cbracket = {
              "<C-[>",
              function(self)
                self.esc_timer = self.esc_timer or (vim.uv or vim.loop).new_timer()
                if self.esc_timer:is_active() then
                  self.esc_timer:stop()
                  vim.cmd("stopinsert")
                else
                  self.esc_timer:start(400, 0, function() end)
                  return "<C-[>"
                end
              end,
              mode = "t",
              expr = true,
              desc = "Double C-[ to normal mode",
            },
          },
        },
      },
    },
    keys = {
      {
        "<c-\\>",
        function()
          Snacks.terminal.toggle()
        end,
        mode = { "n", "t" },
        desc = "Toggle Terminal",
      },
      {
        "<leader>\\",
        function()
          Snacks.terminal.toggle()
        end,
        mode = { "n", "t" },
        desc = "Toggle Terminal",
      },
    },
    config = function()
      -- Explicit keymaps for reliability (in case lazy keys have conflicts)
      vim.keymap.set({ "n", "t" }, "<c-\\>", function()
        Snacks.terminal.toggle()
      end, { desc = "Toggle Terminal" })
      vim.keymap.set({ "n", "t" }, "<leader>\\", function()
        Snacks.terminal.toggle()
      end, { desc = "Toggle Terminal" })

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
