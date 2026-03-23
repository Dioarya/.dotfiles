return {
  "neovim/nvim-lspconfig",
  dependencies = require "configs.nvim-lspconfig.deps",
  config = function()
    require "configs.nvim-lspconfig.config"
  end,
}
