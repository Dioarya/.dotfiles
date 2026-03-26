return {
  "williamboman/mason.nvim",
  cmd = { "Mason", "MasonInstall", "MasonUpdate" },
  dependencies = require "custom.configs.mason.deps",
  opts = require "custom.configs.mason.opts",
  config = require "custom.configs.mason.config",
}
