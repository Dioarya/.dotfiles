return {
  require "plugins.mason", -- NOTE: Must be loaded before dependants
  "williamboman/mason-lspconfig.nvim",
  require "plugins.mason-tool-installer",
  { "j-hui/fidget.nvim", opts = {} },
  { "folke/neodev.nvim", opts = {} },
  -- "hrsh7th/cmp-nvim-lsp",
}
