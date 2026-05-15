return {
  "antosha417/nvim-lsp-file-operations",
  dependencies = require "custom.configs.nvim-lsp-file-operations.deps",
  config = function(_, opts)
    return (require "custom.configs.nvim-lsp-file-operations.config")(_, opts)
  end,
  opts = require "custom.configs.nvim-lsp-file-operations.opts",
}
