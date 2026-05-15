return {
  "williamboman/mason.nvim",
  cmd = { "Mason", "MasonInstall", "MasonUpdate" },
  dependencies = require "custom.configs.mason.deps",
  opts = require "custom.configs.mason.opts",
  init = require "custom.configs.mason.initfn",
}
