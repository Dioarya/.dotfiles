-- local function on_init(client, _)
--   if vim.fn.has "nvim-0.11" ~= 1 then
--     if client.supports_method "textDocument/semanticTokens" then
--       client.server_capabilities.semanticTokensProvider = nil
--     end
--   else
--     if client:supports_method "textDocument/semanticTokens" then
--       client.server_capabilities.semanticTokensProvider = nil
--     end
--   end
-- end
--
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
--
-- capabilities.textDocument.completion.completionItem = {
--   documentationFormat = { "markdown", "plaintext" },
--   snippetSupport = true,
--   preselectSupport = true,
--   insertReplaceSupport = true,
--   labelDetailsSupport = true,
--   deprecatedSupport = true,
--   commitCharactersSupport = true,
--   tagSupport = { valueSet = { 1 } },
--   resolveSupport = {
--     properties = {
--       "documentation",
--       "detail",
--       "additionalTextEdits",
--     },
--   },
-- }

-- vim.lsp.config("*", { capabilities = capabilities, on_init = on_init })

-- capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
-- capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

local capabilities = require("blink.cmp").get_lsp_capabilities(nil, true)

local servers = (require "custom.lsps").servers

for name, configuration in pairs(servers) do
  if type(configuration) == "function" then
    configuration = configuration()
  end
  configuration.capabilities = vim.tbl_deep_extend("force", {}, capabilities, configuration.capabilities or {})
  vim.lsp.config(name, configuration)
  vim.lsp.enable(name)
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lspconfig-lsp-attach", { clear = true }),
  callback = function(event)
    (require "custom.configs.nvim-lspconfig.on_attach")(event)
  end,
})
