return { -- Fuzzy Finder (files, lsp, etc)
  "nvim-telescope/telescope.nvim",
  event = "VimEnter",
  branch = "0.1.x",
  dependencies = require "configs.telescope.deps",
  config = function()
    require "configs.telescope.config"
  end,
}
