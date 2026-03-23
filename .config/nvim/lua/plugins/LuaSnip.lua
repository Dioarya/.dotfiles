return {
  "L3MON4D3/LuaSnip",
  event = "InsertEnter",
  build = (require "configs.LuaSnip.build")(),
  dependencies = require "configs.LuaSnip.deps",
  opts = require "configs.LuaSnip.opts",
  config = function(_, opts)
    (require "configs.LuaSnip.config")(_, opts)
  end,
}
