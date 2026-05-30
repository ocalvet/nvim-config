return {
  {
    -- Fast, async formatter — replaces none-ls for all formatting needs
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = { "n", "v" },
        desc = "Format buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff_fix", "ruff_format" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        less = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        go = { "goimports" },
        sh = { "shfmt" },
        bash = { "shfmt" },
        terraform = { "terraform_fmt" },
        c = { "clang_format" },
        cpp = { "clang_format" },
        cuda = { "clang_format" },
      },
      formatters = {
        shfmt = { prepend_args = { "-i", "2" } },
        clang_format = { prepend_args = { "--style=file", "--fallback-style=llvm" } },
      },
      format_on_save = {
        timeout_ms = 1000,
        lsp_fallback = true,
      },
    },
  },
  {
    -- Async linter — replaces none-ls diagnostics
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        javascript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        make = { "checkmake" },
      }

      -- Only run eslint_d when a config file exists in the project root
      local eslint = lint.linters.eslint_d
      local original_condition = eslint.condition
      eslint.condition = function(ctx)
        local eslint_configs = {
          ".eslintrc.js", ".eslintrc.json", ".eslintrc.yaml",
          ".eslintrc.yml", ".eslintrc", "eslint.config.js",
        }
        for _, f in ipairs(eslint_configs) do
          if vim.uv.fs_stat(ctx.dirname .. "/" .. f) then
            return true
          end
        end
        return false
      end

      -- Trigger linting after writes and when leaving insert mode
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
  {
    -- Mason integration: ensure formatters/linters are installed
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = {
        "prettier",
        "eslint_d",
        "shfmt",
        "checkmake",
        "stylua",
        "goimports",
        "clang-format",
        "ruff",
      },
      auto_update = false,
      run_on_start = true,
    },
  },
}
