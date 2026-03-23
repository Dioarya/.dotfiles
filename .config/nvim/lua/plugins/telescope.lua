return { -- Fuzzy Finder (files, lsp, etc)
  "nvim-telescope/telescope.nvim",
  -- event = "VimEnter",
  event = "VeryLazy",
  branch = "0.1.x",
  cmd = "Telescope",
  dependencies = require "configs.telescope.deps",
  config = function()
    require "configs.telescope.config"
  end,
}
