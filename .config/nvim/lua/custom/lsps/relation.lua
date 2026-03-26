---@param filetypes_whitelist boolean
---@param servers_whitelist boolean
return function(filetypes_whitelist, servers_whitelist)
  local M = {}

  local filetypes_servers = {
    bash = { "bashls" },
    c = { "clangd", "codelldb" },
    cpp = { "clangd", "codelldb" },
    csh = { "bashls" },
    csharp = { "roslyn" },
    css = { "cssls" },
    go = { "gopls", "delve" },
    html = { "cssls" },
    javascript = { "vtsls" },
    javascriptreact = { "vtsls" },
    json = { "jsonls" },
    ksh = { "bashls" },
    latex = { "vale" },
    less = { "cssls" },
    lua = { "lua_ls", "stylua" },
    luau = { "stylua" },
    markdown = { "vale" },
    powershell = { "powershell_es" },
    python = { "pyright" },
    rust = { "rust_analyzer", "codelldb" },
    scss = { "cssls" },
    sh = { "bashls" },
    text = { "vale" },
    typescript = { "vtsls" },
    typescriptreact = { "vtsls" },
    vue = { "vtsls", "vue_ls" },
    zig = { "codelldb" },
    zsh = { "bashls" },
  }

  ---@type table<string, filetype_config>
  M.filetypes = {}
  ---@type table<string, boolean>
  M.servers = {}
  for filetype, servers in pairs(filetypes_servers) do
    for _, server in ipairs(servers) do
      if M.servers[server] == nil then
        M.servers[server] = servers_whitelist
      end
    end
    ---@type filetype_config
    local new_table = {
      enable = filetypes_whitelist,
      servers = servers,
    }
    M.filetypes[filetype] = new_table
  end

  return M
end
