return {
  "neovim/nvim-lspconfig",
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for Neovim
    { "mason-org/mason.nvim", config = true },
    -- mason-lspconfig bridges LSP config names to Mason package names
    {
      "mason-org/mason-lspconfig.nvim",
      opts = {
        ensure_installed = {
          "ts_ls", "pyright", "html", "cssls", "tailwindcss",
          "dockerls", "sqlls", "terraformls", "jsonls", "yamlls", "gopls", "lua_ls",
        },
      },
    },
    -- Useful status updates for LSP
    {
      "j-hui/fidget.nvim",
      opts = {
        notification = {
          window = { winblend = 0 },
        },
      },
    },
  },
  config = function()
    -- Diagnostics configuration
    vim.diagnostic.config({
      virtual_text = { prefix = "●", spacing = 4 },
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      float = {
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })

    -- Diagnostic signs
    local signs = { Error = " ", Warn = " ", Hint = "󰌵 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or "n"
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        -- Navigation
        map("gd", require("telescope.builtin").lsp_definitions, "Goto Definition")
        map("gr", require("telescope.builtin").lsp_references, "Goto References")
        map("gI", require("telescope.builtin").lsp_implementations, "Goto Implementation")
        map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type Definition")
        map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "Document Symbols")
        map("<leader>fws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols")

        -- Actions
        map("<leader>rn", vim.lsp.buf.rename, "Rename")
        map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "x" })
        map("gD", vim.lsp.buf.declaration, "Goto Declaration")

        -- Highlight references on cursor hold
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
          local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd("LspDetach", {
            group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
            end,
          })
        end

        -- Toggle inlay hints
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
          map("<leader>th", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
          end, "Toggle Inlay Hints")
        end
      end,
    })

    -- Create capabilities with nvim-cmp support
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

    -- Server configurations
    local servers = {
      ts_ls = {},
      pyright = {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
            },
          },
        },
      },
      html = { filetypes = { "html", "twig", "hbs" } },
      cssls = {},
      tailwindcss = {},
      dockerls = {},
      sqlls = {},
      terraformls = {},
      jsonls = {},
      yamlls = {},
      gopls = {},
      lua_ls = {
        settings = {
          Lua = {
            completion = { callSnippet = "Replace" },
            runtime = { version = "LuaJIT" },
            workspace = {
              checkThirdParty = false,
              library = vim.api.nvim_get_runtime_file("", true),
            },
            diagnostics = {
              globals = { "vim" },
              disable = { "missing-fields" },
            },
            format = { enable = false },
          },
        },
      },
    }

    -- Configure and enable all servers
    for server, cfg in pairs(servers) do
      cfg.capabilities = vim.tbl_deep_extend("force", {}, capabilities, cfg.capabilities or {})
      vim.lsp.config(server, cfg)
      vim.lsp.enable(server)
    end
  end,
}
