local filetype_modules = {
  "bash",
  "cpp",
  "csharp",
  "css",
  "go",
  "html",
  "javascript",
  "javascriptreact",
  "json",
  "lua",
  "powershell",
  "python",
  "rust",
  "typescript",
  "typescriptreact",
  "vue",
}

-- servers are actually set up in nvim-lspconfig configs (configs.nvim-lspconfig.config) function.
-- more info about the `config` vs `setup` registration distinction there.

-- build server_name -> filetypes map
local server_filetypes = {}
for _, ft in ipairs(filetype_modules) do
  local servers = require("lsps.filetypes." .. ft)
  for _, name in ipairs(servers) do
    if not server_filetypes[name] then
      server_filetypes[name] = {}
    end
    table.insert(server_filetypes[name], ft)
  end
end

-- load per-server config and inject filetypes
local servers = {}
for name, filetypes in pairs(server_filetypes) do
  local ok, config = pcall(require, "lsps.configs." .. name)
  config = ok and config or {}
  config.setup = config.setup or {}
  config.setup.filetypes = filetypes
  servers[name] = config
end

return servers
