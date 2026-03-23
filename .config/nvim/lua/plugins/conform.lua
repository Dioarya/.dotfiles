return {
  "stevearc/conform.nvim",
  lazy = false,
  keys = require "configs.conform.keys",
  opts = require "configs.conform.opts",
  config = function(_, opts)
    (require "configs.conform.config")(opts)
  end,
}
