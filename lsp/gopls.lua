return {
  cmd = { 'gopls' },
  filetypes = { 'go' },
  root_markers = { 'go.mod', 'go.work', '.git' },
  settings = {
    gopls = {
      -- Enable gofumpt-style formatting if you have gofumpt installed
      gofumpt = true,
    },
  },
}
