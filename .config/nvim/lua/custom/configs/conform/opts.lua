---@param bufnr integer
---@param ... string
---@return string
local function first(bufnr, ...)
  local conform = require "conform"
  for i = 1, select("#", ...) do
    local formatter = select(i, ...)
    if conform.get_formatter_info(formatter, bufnr).available then
      return formatter
    end
  end
  return select(1, ...)
end

---@param formatters custom.lsps
local function process_formatters(formatters)
  local new_formatters = {}
  for language, configuration in pairs(formatters) do
    if type(configuration) == "function" then
      configuration = configuration()
    end
    new_formatters[language] = configuration
  end

  return new_formatters
end

return {
  notify_on_error = false,
  format_on_save = function(bufnr)
    local filetype = vim.bo[bufnr].filetype
    -- Disable autoformat on certain filetypes.
    local ignore_filetypes = require("custom.configs.conform.filetypes").ignore_filetypes
    if ignore_filetypes[filetype] == true then
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

    local disable_filetypes = require("custom.configs.conform.filetypes").disable_filetypes
    return {
      timeout_ms = 5000,
      lsp_fallback = not disable_filetypes[filetype],
    }
  end,
  formatters_by_ft = {
    c = { "clang-format" },
    cpp = { "clang-format" },
    css = { "oxfmt", "stylelint" }, -- injected
    html = { "oxfmt" }, -- injected
    java = { "clang-format" },
    javascript = { "oxfmt" }, -- injected
    javascriptreact = { "oxfmt" }, -- injected
    lua = { "stylua" },
    python = { "isort", "black" },
    svg = { "prettierd", "prettier", stop_after_first = true }, -- injected
    typescript = { "oxfmt" }, -- injected
    typescriptreact = { "oxfmt" }, -- injected
    vue = { "oxfmt" }, -- injected
  },

  default_format_opts = {
    async = true,
    quiet = false,
  },

  -- Formatter configuration
  formatters = process_formatters(require("custom.lsps").formatters),
}
