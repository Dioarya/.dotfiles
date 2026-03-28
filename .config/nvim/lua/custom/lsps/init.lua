---@class (exact) language_config
---@field enable boolean
---@field servers string[]

---@class (exact) server_config
---@field setup table
---@field config table

local M = {}

local languages_whitelist = true
local servers_whitelist = true

-- This is additional control for quick enables and disables for specific filetypes and/or servers.
-- write language/server to boolean map in the corresponding variables below to enable/disable them

---@type table<string, boolean>
local language_configs = {}
---@type table<string, boolean>
local server_configs = {
  ts_ls = false,
}

---@type table<string, language_config>
local language_overrides = {}
for language, enable in pairs(language_configs) do
  language_overrides[language] = { enable = enable }
end

M.relation = (require "custom.lsps.relation")(languages_whitelist, servers_whitelist)
M.relation.languages = vim.tbl_extend("force", M.relation.languages, language_overrides)
M.relation.servers = vim.tbl_extend("force", M.relation.servers, server_configs)

-- servers are actually set up in nvim-lspconfig configs (configs.nvim-lspconfig.config) function.
-- more info about the `config` vs `setup` registration distinction there.

-- build server -> languages map
local server_languages = {}
for language, config in pairs(M.relation.languages) do
  if not config.enable then
    goto continue_language
  end

  for _, server in ipairs(config.servers) do
    if not M.relation.servers[server] then
      goto continue_server
    end

    if not server_languages[server] then
      server_languages[server] = {}
    end
    table.insert(server_languages[server], language)
    ::continue_server::
  end
  ::continue_language::
end

-- load per-server config and inject languages
---@type table<string, server_config>
M.servers = {}
for server, languages in pairs(server_languages) do
  local ok, config = pcall(require, "custom.lsps.configs." .. server)
  if ok then
    config = config or {}
  else
    config = {}
  end
  config.config = config.config or {}
  config.setup = config.setup or {}
  config.setup.filetypes = languages
  M.servers[server] = config
end

-- build language -> servers map
---@type table<string, string[]>
M.languages = {}
local language_servers = {}
for language, config in pairs(M.relation.languages) do
  if not config.enable then
    goto continue_language
  end

  for _, server in ipairs(config.servers) do
    if not M.relation.servers[server] then
      goto continue_server
    end

    if not language_servers[language] then
      language_servers[language] = {}
    end
    table.insert(language_servers[language], server)
    ::continue_server::
  end
  ::continue_language::
end
M.languages = language_servers

return M
