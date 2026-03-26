---@class (exact) filetype_config
---@field enable boolean
---@field servers string[]

---@class (exact) server_config
---@field setup table
---@field config table

local M = {}

local filetypes_whitelist = true
local servers_whitelist = true

-- write filetype/server to boolean map in the corresponding variables below to enable/disable them

---@type table<string, boolean>
local filetype_configs = {}
---@type table<string, boolean>
local server_configs = {
  ts_ls = false,
}

---@type table<string, filetype_config>
local filetype_overrides = {}
for filetype, enable in pairs(filetype_configs) do
  filetype_overrides[filetype] = { enable = enable }
end

M.relation = (require "custom.lsps.relation")(filetypes_whitelist, servers_whitelist)
M.relation.filetypes = vim.tbl_extend("force", M.relation.filetypes, filetype_overrides)
M.relation.servers = vim.tbl_extend("force", M.relation.servers, server_configs)

-- servers are actually set up in nvim-lspconfig configs (configs.nvim-lspconfig.config) function.
-- more info about the `config` vs `setup` registration distinction there.

-- build server -> filetypes map
local server_filetypes = {}
for filetype, config in pairs(M.relation.filetypes) do
  if not config.enable then
    goto continue_filetype
  end

  for _, server in ipairs(config.servers) do
    if not M.relation.servers[server] then
      goto continue_server
    end

    if not server_filetypes[server] then
      server_filetypes[server] = {}
    end
    table.insert(server_filetypes[server], filetype)
    ::continue_server::
  end
  ::continue_filetype::
end

-- load per-server config and inject filetypes
---@type table<string, server_config>
M.servers = {}
for server, filetypes in pairs(server_filetypes) do
  local ok, config = pcall(require, "custom.lsps.configs." .. server)
  config = (ok and config) or {}
  config.setup = config.setup or {}
  config.setup.filetypes = filetypes
  M.servers[server] = config
end

-- build filetype -> servers map
---@type table<string, string[]>
M.filetypes = {}
local filetype_servers = {}
for filetype, config in pairs(M.relation.filetypes) do
  if not config.enable then
    goto continue_filetype
  end

  for _, server in ipairs(config.servers) do
    if not M.relation.servers[server] then
      goto continue_server
    end

    if not filetype_servers[filetype] then
      filetype_servers[filetype] = {}
    end
    table.insert(filetype_servers[filetype], server)
    ::continue_server::
  end
  ::continue_filetype::
end
M.filetypes = filetype_servers

return M
