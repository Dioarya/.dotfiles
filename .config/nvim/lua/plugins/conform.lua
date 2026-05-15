return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = { "ConformInfo" },
  keys = require "custom.configs.conform.keys",
  opts = require "custom.configs.conform.opts",
  config = require "custom.configs.conform.config",
}
