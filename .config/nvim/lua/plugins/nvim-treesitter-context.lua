return { -- Sticky Scroll
  "nvim-treesitter/nvim-treesitter-context",
  event = "BufReadPost",
  opts = require "custom.configs.nvim-treesitter-context.opts",
}
