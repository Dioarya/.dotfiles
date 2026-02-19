vim.lsp.config('clangd', {
  cmd = {
    'clangd',
    '--background-index',
    '--suggest-missing-includes',
    '--query-driver=C:\\msys64\\ucrt64\\bin\\g++.exe',
  },
})
