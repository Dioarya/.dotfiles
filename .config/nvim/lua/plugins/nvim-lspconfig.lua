return {
  "neovim/nvim-lspconfig",
  dependencies = require "custom.configs.nvim-lspconfig.deps",
  config = function()
    require "custom.configs.nvim-lspconfig.config"
  end,
}
