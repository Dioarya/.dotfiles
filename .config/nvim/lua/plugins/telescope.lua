return { -- Fuzzy Finder (files, lsp, etc)
  "nvim-telescope/telescope.nvim",
  -- event = "VimEnter",
  event = "VeryLazy",
  branch = "0.1.x",
  cmd = "Telescope",
  dependencies = require "custom.configs.telescope.deps",
  config = function()
    require "custom.configs.telescope.config"
  end,
}
