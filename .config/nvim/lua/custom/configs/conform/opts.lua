return {
  notify_on_error = false,
  format_on_save = function(bufnr)
    -- Disable autoformat on certain filetypes.
    local ignore_filetypes = { "html" }
    if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
      return
    end
    -- Disable with a global or buffer-local variable
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    -- Disable autoformat for files in a certain path
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    if
      bufname:match "/node_modules/"
      or bufname:match "\\node_modules/"
      or bufname:match "/node_modules\\"
      or bufname:match "\\node_modules\\"
    then
      return
    end

    local disable_filetypes = require "custom.configs.conform.disable_filetypes"
    return {
      timeout_ms = 500,
      lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
    }
  end,
  formatters_by_ft = {
    lua = { "stylua" },
    -- Conform can also run multiple formatters sequentially
    python = { "isort", "autopep8" },
    html = { "prettierd", "prettier", stop_after_first = true },
    javascript = { "prettierd", "prettier", stop_after_first = true },
    typescript = { "prettierd", "prettier", stop_after_first = true },
    vue = { "prettierd", "prettier", stop_after_first = true },
  },
}
