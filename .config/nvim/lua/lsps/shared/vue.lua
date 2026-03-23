local M = {}

local vue_language_server_path = vim.fn.expand "$MASON/packages"
  .. "/vue-language-server"
  .. "/node_modules/@vue/language-server"

M.tsserver_filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" }

M.vue_plugin = {
  name = "@vue/typescript-plugin",
  location = vue_language_server_path,
  languages = { "vue" },
  configNamespace = "typescript",
}

return M
