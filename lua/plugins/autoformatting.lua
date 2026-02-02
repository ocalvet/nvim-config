return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
    "jayp0521/mason-null-ls.nvim",
  },
  config = function()
    local null_ls = require("null-ls")
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics

    -- Formatters & linters for mason to install
    require("mason-null-ls").setup({
      ensure_installed = {
        "prettier",
        "eslint_d",
        "shfmt",
        "checkmake",
      },
      automatic_installation = true,
    })

    local sources = {
      diagnostics.checkmake,
      formatting.prettier.with({
        filetypes = {
          "html", "json", "yaml", "markdown",
          "javascript", "javascriptreact",
          "typescript", "typescriptreact",
          "css", "scss", "less",
        },
      }),
      formatting.stylua,
      formatting.shfmt.with({ args = { "-i", "2" } }),
      formatting.terraform_fmt,
      require("none-ls.formatting.ruff").with({ extra_args = { "--extend-select", "I" } }),
      require("none-ls.formatting.ruff_format"),
      require("none-ls.diagnostics.eslint_d").with({
        condition = function(utils)
          return utils.root_has_file({
            ".eslintrc.js", ".eslintrc.json", ".eslintrc.yaml",
            ".eslintrc.yml", ".eslintrc", "eslint.config.js",
          })
        end,
      }),
    }

    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    null_ls.setup({
      sources = sources,
      on_attach = function(client, bufnr)
        if client:supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ async = false })
            end,
          })
        end
      end,
    })
  end,
}
