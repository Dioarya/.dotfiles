return {
  "williamboman/mason.nvim",
  cmd = { "Mason", "MasonInstall", "MasonUpdate" },
  opts = require "configs.mason.opts",
  config = function()
    require "configs.mason.config"
  end,
}
