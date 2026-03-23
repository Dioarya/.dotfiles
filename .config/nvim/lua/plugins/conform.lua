return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  keys = require "configs.conform.keys",
  opts = require "configs.conform.opts",
  config = function(_, opts)
    (require "configs.conform.config")(opts)
  end,
}
