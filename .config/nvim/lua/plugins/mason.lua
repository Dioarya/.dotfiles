return {
  "williamboman/mason.nvim",
  cmd = { "Mason", "MasonInstall", "MasonUpdate" },
  opts = require "custom.configs.mason.opts",
  config = function()
    require "custom.configs.mason.config"
  end,
}
