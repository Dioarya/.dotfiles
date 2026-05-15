return {
  require "plugins.mason", -- NOTE: Must be loaded before dependants
  require "plugins.mason-lspconfig", -- mason-lspconfig only serves as a bridge between mason names and lspconfig names
  -- require "plugins.mason-tool-installer",
  -- require "plugins.fidget",
  -- require "plugins.nvim-lsp-notify",
  require "plugins.lazydev",
  require "plugins.blink-cmp",
  require "plugins.telescope",
  -- "hrsh7th/cmp-nvim-lsp",

  require "plugins.workspace-diagnostics",
}
