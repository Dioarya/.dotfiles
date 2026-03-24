local function on_init(client, _)
  if vim.fn.has "nvim-0.11" ~= 1 then
    if client.supports_method "textDocument/semanticTokens" then
      client.server_capabilities.semanticTokensProvider = nil
    end
  else
    if client:supports_method "textDocument/semanticTokens" then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end
end

local x = vim.diagnostic.severity

vim.diagnostic.config {
  virtual_text = { prefix = "" },
  signs = { text = { [x.ERROR] = "󰅙", [x.WARN] = "", [x.INFO] = "󰋼", [x.HINT] = "󰌵" } },
  underline = true,
  float = { border = "single" },
}

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

vim.lsp.config("*", { capabilities = capabilities, on_init = on_init })

-- capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

local servers = require "lsps"

-- config is split into two: native vim.lsp.config() for servers managed by the native LSP API,
-- and lspconfig setup() for everything else.

for name, config in pairs(servers) do
  if config.config then
    vim.lsp.config(name, config.config)
  end
end

require("mason-lspconfig").setup {
  handlers = {
    function(server_name)
      local setup = servers[server_name].setup or {}
      setup.capabilities = vim.tbl_deep_extend("force", {}, capabilities, setup.capabilities or {})
      require("lspconfig")[server_name].setup(setup)
    end,
  },
}

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lspconfig-lsp-attach", { clear = true }),
  callback = function(event)
    (require "configs.nvim-lspconfig.on_attach")(event)
  end,
})
