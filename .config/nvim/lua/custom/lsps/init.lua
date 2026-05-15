---@class (exact) custom.lsps
---@field relation custom.lsps.relation
---@field languages table<string, custom.lsps.LanguageConfig> map language -> full filtered package config; used by mason
---@field servers table<string, custom.lsps.ServerConfig | custom.lsps.ServerConfigDefer> map server -> server config
---@field formatters table<string, custom.lsps.FormatterConfig | custom.lsps.FormatterConfigDefer> map formatter -> formatter config
---@field linters table<string, custom.lsps.LinterConfig | custom.lsps.LinterConfigDefer> map linter -> linter config
---@field daps table<string, custom.lsps.DAPConfig | custom.lsps.DAPConfigDefer> map DAP adapter -> DAP config

---@class (exact) custom.lsps.relation relation between languages and its packages, only enable/disable state.
---@field language_data table<string, custom.lsps.relation.language_data> raw unfiltered package lists per language
---@field languages table<string, boolean> map language -> enabled/disabled
---@field servers table<string, boolean> map servers -> enabled/disabled
---@field formatters table<string, boolean> map formatters -> enabled/disabled
---@field linters table<string, boolean> map linters -> enabled/disabled
---@field daps table<string, boolean> map DAPs -> enabled/disabled

---@class (exact) custom.lsps.relation.language_data raw package lists for a language, without enable/disable state
---@field servers string[] list of servers
---@field formatters string[] list of formatters
---@field linters string[] list of linters
---@field daps string[] list of DAPs
---@field packages string[] union of servers + formatters + linters + daps

---@class (exact) custom.lsps.LanguageConfig
---@field servers string[] enabled servers for this language
---@field formatters string[] enabled formatters for this language
---@field linters string[] enabled linters for this language
---@field daps string[] enabled DAP adapters for this language
---@field packages string[] union of all enabled packages for this language; used by mason

--- vim.lsp.config per-server config. Passed into vim.lsp.config(server, config) after adding capabilities.
---@class (exact) custom.lsps.ServerConfig : vim.lsp.Config
---@alias custom.lsps.ServerConfigDefer fun(): custom.lsps.ServerConfig

--- conform.nvim per-formatter config. Passed directly into the `formatters` table of conform.setup().
--- Full field reference: https://github.com/stevearc/conform.nvim#formatter-options
---@class (exact) custom.lsps.FormatterConfig : conform.FileFormatterConfig
---@alias custom.lsps.FormatterConfigDefer fun(): custom.lsps.FormatterConfig

--- nvim-lint per-linter config. Passed directly into the `linters` table of lint setup.
--- Full field reference: https://github.com/mfussenegger/nvim-lint#custom-linters
---@class (exact) custom.lsps.LinterConfig : lint.Linter
---@alias custom.lsps.LinterConfigDefer fun(): custom.lsps.LinterConfig

--- nvim-dap per-adapter config. `adapter` is registered as dap.adapters[name],
--- `configurations` entries are appended into dap.configurations[lang] for each language.
--- Full field reference: https://github.com/mfussenegger/nvim-dap/blob/master/doc/dap.txt
---@class (exact) custom.lsps.DAPConfig : dap.Adapter
---@alias custom.lsps.DAPConfigDefer fun(): custom.lsps.DAPConfig

local M = {} ---@type custom.lsps

local relation_overrides = require "custom.lsps.overrides"

M.relation = vim.tbl_deep_extend("force", require "custom.lsps.relation", relation_overrides)

-- filters a string list by a flat boolean enable map, returning only enabled entries
---@param entries string[]
---@param enable_map table<string, boolean>
---@return string[]
local function filter_enabled(entries, enable_map)
  ---@type string[]
  local result = {}
  for _, entry in ipairs(entries) do
    if enable_map[entry] then
      table.insert(result, entry)
    end
  end
  return result
end

-- deduplicates a list of string lists into a single ordered list
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

-- loads a config from custom.lsps.configs.<name>, returning {} if none exists
---@param name string
---@return function | table
local function load_config(name)
  local ok, config = pcall(require, "custom.lsps.configs." .. name)
  return (ok and config) or {}
end

M.languages = {} ---@type table<string, custom.lsps.LanguageConfig>
for language, enabled in pairs(M.relation.languages) do
  if not enabled then
    goto continue
  end

  local data = M.relation.language_data[language]
  local servers = filter_enabled(data.servers, M.relation.servers)
  local formatters = filter_enabled(data.formatters, M.relation.formatters)
  local linters = filter_enabled(data.linters, M.relation.linters)
  local daps = filter_enabled(data.daps, M.relation.daps)

  M.languages[language] = { ---@type custom.lsps.LanguageConfig
    servers = servers,
    formatters = formatters,
    linters = linters,
    daps = daps,
    -- rebuild packages from filtered lists to exclude any disabled entries
    packages = union { servers, formatters, linters, daps },
  }

  ::continue::
end

-- load per-server config and inject languages
M.servers = {} ---@type table<string, custom.lsps.ServerConfig | custom.lsps.ServerConfigDefer>
for language, lang_config in pairs(M.languages) do
  for _, server in ipairs(lang_config.servers) do
    if not M.servers[server] then
      local config = load_config(server) --- @type custom.lsps.ServerConfig | custom.lsps.ServerConfigDefer
      if type(config) == "function" then
        -- local old_configuration = config
        -- ---@type custom.lsps.ServerConfigDefer
        -- local new_configuration = function()
        --   local configuration = old_configuration()
        --   configuration.filetypes = {}
        --   return configuration
        -- end
        -- config = new_configuration
      else
        -- config.filetypes = {}
      end
      M.servers[server] = config
    end
    if type(M.servers[server]) == "function" then
      -- local old_configuration = M.servers[server]
      -- ---@type custom.lsps.ServerConfigDefer
      -- local new_configuration = function()
      --   local configuration = old_configuration()
      --   table.insert(configuration.filetypes, language)
      --   return configuration
      -- end
      -- M.servers[server] = new_configuration
    else
      -- table.insert(M.servers[server].filetypes, language)
    end
  end
end

-- load per-tool config for formatters, daps and linters. Config files live at
-- custom.lsps.configs.<tool_name> and return the respective Config table.
M.formatters = {} ---@type table<string, custom.lsps.FormatterConfig | custom.lsps.FormatterConfigDefer>
M.linters = {} ---@type table<string, custom.lsps.LinterConfig | custom.lsps.LinterConfigDefer>
M.daps = {} ---@type table<string, custom.lsps.DAPConfig | custom.lsps.DAPConfigDefer>
for _, entry in ipairs {
  { source = M.relation.formatters, target = M.formatters },
  { source = M.relation.daps, target = M.daps },
  { source = M.relation.linters, target = M.linters },
} do
  for tool, enabled in pairs(entry.source) do
    if enabled then
      entry.target[tool] = load_config(tool)
    end
  end
end

return M
