return { -- Sticky Scroll
  "nvim-treesitter/nvim-treesitter-context",
  event = "BufReadPost",
  opts = require "configs.nvim-treesitter-context.opts",
}
