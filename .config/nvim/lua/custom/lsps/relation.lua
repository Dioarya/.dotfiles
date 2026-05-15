-- This file completely mandates what filetype is directly linked to what mason
-- package(s) (lsp, formatter, dap, linter) are installed and can be
-- enabled/disabled per filetype/lsp/formatter/dap/linter through
-- `custom.lsps.overrides`.
--
-- Keys in all four tables below are Neovim filetypes - the value of
-- `vim.bo.filetype` when a buffer is opened. These are defined as the
-- right-hand side of mappings in the extension/filename/pattern tables inside
-- `$VIMRUNTIME/lua/vim/filetype.lua`, which is the canonical source of truth
-- for filetype detection. To register a new filetype for a custom extension,
-- use `vim.filetype.add`:
--
-- ```lua
-- vim.filetype.add({
--   extension = {
--     ["myext"] = "myfiletype"  -- left: file extension, right: filetype name
--   }
-- })
-- ```
--
-- Note: some entries in filetype.lua resolve multiple extensions or filenames
-- to the same filetype. For example, `.bash`, `.bashrc`, and `.ksh` all
-- resolve to `sh`. Always use the resolved filetype as the key — you can
-- confirm it for any open buffer with `:set ft?`.
--
-- Server keys are from nvim-lspconfig, or mason package names if not in
-- lspconfig.
---@type custom.lsps.relation
local M = {}

-- This table represents what filetypes a server may connect to.
---@type table<string, string[]>
local language_servers = {
  c = { "clangd" },
  cpp = { "clangd" },
  csh = { "bashls" },
  css = { "cssls", "tailwindcss", "stylelint_lsp" },
  go = { "gopls" },
  html = { "cssls" },
  java = { "jdtls" },
  javascript = { "vtsls", "ts_ls", "oxlint", "tailwindcss" },
  javascriptreact = { "vtsls", "ts_ls", "oxlint", "tailwindcss" },
  json = { "jsonls" },
  less = { "cssls" },
  lua = { "lua_ls" },
  luau = { "luau-lsp" },
  ps1 = { "powershell_es" },
  python = { "basedpyright", "pyright" },
  rust = { "rust_analyzer" },
  scss = { "cssls" },
  sh = { "bashls" },
  typescript = { "vtsls", "ts_ls", "oxlint", "tailwindcss" },
  typescriptreact = { "vtsls", "ts_ls", "oxlint", "tailwindcss" },
  vue = { "vtsls", "ts_ls", "oxlint", "vue_ls" },
  zsh = { "bashls" },
}

-- Formatters are managed separately from LSP servers (e.g. via conform.nvim).
-- They are intentionally excluded from language_servers to avoid being passed
-- to vim.lsp.config() or lspconfig.setup(), which would error on missing cmd.
---@type table<string, string[]>
local language_formatters = {
  c = { "clang-format" },
  cpp = { "clang-format" },
  css = { "stylelint" },
  java = { "clang-format" },
  javascript = { "prettierd", "prettier", "oxfmt" },
  javascriptreact = { "prettierd", "prettier", "oxfmt" },
  lua = { "stylua" },
  luau = { "stylua" },
  python = { "black" },
  typescript = { "prettierd", "prettier", "oxfmt" },
  typescriptreact = { "prettierd", "prettier", "oxfmt" },
  svg = { "prettierd", "prettier" },
}

-- DAP adapters are managed separately from LSP servers (e.g. via nvim-dap).
-- Same reasoning as language_formatters; They are not LSP servers.
---@type table<string, string[]>
local language_daps = {
  c = { "codelldb" },
  cpp = { "codelldb" },
  go = { "delve" },
  rust = { "codelldb" },
}

-- Linters are managed separately from LSP servers (e.g. via nvim-lint).
-- Same reasoning as language_formatters; They are not LSP servers.
---@type table<string, string[]>
local language_linters = {
  make = { "checkmake" },
  markdown = { "markdownlint" },
  python = { "mypy" },
  tex = { "vale" },
  text = { "vale" },
}

-- returns a flat boolean map of all unique values across a language->[]string table
---@param lang_map table<string, string[]>
---@return table<string, boolean>
local function make_flat_map(lang_map)
  ---@type table<string, boolean>
  local flat = {}
  for _, entries in pairs(lang_map) do
    for _, entry in ipairs(entries) do
      if flat[entry] == nil then
        flat[entry] = true
      end
    end
  end
  return flat
end

-- collects all unique language keys across any number of language->[]string tables
---@param ... table<string, string[]>
---@return table<string, boolean>
local function collect_languages(...)
  ---@type table<string, boolean>
  local all = {}
  for _, lang_map in ipairs { ... } do
    for lang, _ in pairs(lang_map) do
      all[lang] = true
    end
  end
  return all
end

-- deduplicates a list of strings, preserving order
---@param lists string[][]
---@return string[]
local function union(lists)
  ---@type string[]
  local result = {}
  ---@type table<string, boolean>
  local seen = {}
  for _, list in ipairs(lists) do
    for _, p in ipairs(list) do
      if not seen[p] then
        seen[p] = true
        table.insert(result, p)
      end
    end
  end
  return result
end

M.languages = collect_languages(language_servers, language_formatters, language_daps, language_linters)
M.servers = make_flat_map(language_servers)
M.formatters = make_flat_map(language_formatters)
M.linters = make_flat_map(language_linters)
M.daps = make_flat_map(language_daps)

-- raw unfiltered package lists per language; init.lua uses this to build lsps.languages
-- after applying the enable/disable maps above
M.language_data = {} ---@type table<string, custom.lsps.relation.language_data>
for lang, _ in pairs(collect_languages(language_servers, language_formatters, language_daps, language_linters)) do
  local servers = language_servers[lang] or {}
  local formatters = language_formatters[lang] or {}
  local daps = language_daps[lang] or {}
  local linters = language_linters[lang] or {}

  M.language_data[lang] = { ---@type custom.lsps.relation.language_data
    servers = servers,
    formatters = formatters,
    daps = daps,
    linters = linters,
    packages = union { servers, formatters, daps, linters },
  }
end

return M
