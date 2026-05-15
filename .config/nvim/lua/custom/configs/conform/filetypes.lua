local M = {}

M.ignore_filetypes = {
  html = true,
  css = true,
}

-- Disable "format_on_save lsp_fallback" for languages that don't
-- have a well standardized coding style. You can add additional
-- languages here or re-enable it for the disabled ones.
M.disable_filetypes = {
  c = true,
  cpp = true,
  ps1 = true,
  powershell = true,
  pwsh = true,
  html = true,
}

return M
