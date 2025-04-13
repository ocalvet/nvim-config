return {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  root_markers = { 'package.json', 'tsconfig.json', '.git' },
  on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }
  end,
  capabilities = vim.lsp.protocol.make_client_capabilities(),
  settings = {},
}
