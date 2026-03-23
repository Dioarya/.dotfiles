local filetypes = {
  require "lsps.filetypes.bash",
  require "lsps.filetypes.cpp",
  require "lsps.filetypes.csharp",
  require "lsps.filetypes.css",
  require "lsps.filetypes.go",
  require "lsps.filetypes.html",
  require "lsps.filetypes.javascript",
  require "lsps.filetypes.javascriptreact",
  require "lsps.filetypes.json",
  require "lsps.filetypes.lua",
  require "lsps.filetypes.powershell",
  require "lsps.filetypes.python",
  require "lsps.filetypes.rust",
  require "lsps.filetypes.typescript",
  require "lsps.filetypes.typescriptreact",
  require "lsps.filetypes.vue",
}

-- servers are actually set up in nvim-lspconfig configs (configs.nvim-lspconfig.config) function.
-- more info about the `config` vs `setup` registration distinction there.

-- flatten all server name lists into a deduped list
local server_names = {}
local seen = {}
for _, ft_servers in ipairs(filetypes) do
  for _, name in ipairs(ft_servers) do
    if not seen[name] then
      seen[name] = true
      table.insert(server_names, name)
    end
  end
end

-- dynamically load config for each server from configs/
local servers = {}
for _, name in ipairs(server_names) do
  local ok, config = pcall(require, "lsps.configs." .. name)
  if ok then
    servers[name] = config
  else
    servers[name] = {}
  end
end

return servers
