---@param languages_whitelist boolean
---@param servers_whitelist boolean
return function(languages_whitelist, servers_whitelist)
  local M = {}

  -- This table represents what languages a server may connect to. This completely replaces the default filetypes a server can connect.
  --
  -- Language keys are from supported treesitter parser names. https://github.com/tree-sitter/tree-sitter/wiki/List-of-parsers
  -- Language keys for files that don't contain an extension use the direct filetype instead. For example, "csh" does not have
  -- a treesitter parser, so "csh" will directly be used to address that filetype's servers.
  --
  -- You may find the language key for the current buffer by typing this command
  -- :lua print(vim.inspect(vim.treesitter.language.get_lang(vim.bo.filetype))) -- Outputs: "lua"
  -- You may also find the language key for an arbitrary filetype by replacing "vim.bo.filetype"
  -- :lua print(vim.inspect(vim.treesitter.language.get_lang("typescriptreact"))) -- Outputs: "tsx"
  --
  -- The server keys are from nvim-lspconfig.
  ---@type table<string, string[]>
  local language_servers = {
    -- Treesitter languages
    bash = { "bashls" },
    c = { "clangd", "codelldb" },
    cpp = { "clangd", "codelldb" },
    c_sharp = { "roslyn" },
    css = { "cssls" },
    go = { "gopls", "delve" },
    html = { "cssls" },
    javascript = { "vtsls" },
    json = { "jsonls" },
    latex = { "vale" },
    lua = { "lua_ls", "stylua" },
    luau = { "luau-lsp", "stylua" },
    make = { "checkmake" },
    markdown = { "vale" },
    powershell = { "powershell_es" },
    python = { "pyright" },
    rust = { "rust_analyzer", "codelldb" },
    scss = { "cssls" },
    sh = { "bashls" },
    typescript = { "vtsls" },
    tsx = { "vtsls" },
    vue = { "vtsls", "vue_ls" },
    zig = { "codelldb" },
    zsh = { "bashls" },
    -- Filetpes
    csh = { "bashls" },
    ksh = { "bashls" },
    less = { "cssls" },
    text = { "vale" },
  }

  ---@type table<string, language_config>
  M.languages = {}
  ---@type table<string, boolean>
  M.servers = {}
  for language, servers in pairs(language_servers) do
    for _, server in ipairs(servers) do
      if M.servers[server] == nil then
        M.servers[server] = servers_whitelist
      end
    end
    ---@type language_config
    local new_table = {
      enable = languages_whitelist,
      servers = servers,
    }
    M.languages[language] = new_table
  end

  return M
end
