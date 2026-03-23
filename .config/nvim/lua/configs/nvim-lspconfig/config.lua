require("nvchad.configs.lspconfig").defaults()

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

local servers = require "lsps"

-- config is split into two: native vim.lsp.config() for servers managed by the native LSP API,
-- and lspconfig setup() for everything else. vtsls, ts_ls, and vue_ls use the native API
-- since it correctly handles filetypes and plugin registration for vue support.

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
    (require "configs.nvim-lspconfig.mappings")(event)
  end,
})
