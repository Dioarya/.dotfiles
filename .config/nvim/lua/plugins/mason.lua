return {
  "williamboman/mason.nvim",
  opts = require "configs.mason.opts",
  config = function()
    require "configs.mason.config"
  end,
}
