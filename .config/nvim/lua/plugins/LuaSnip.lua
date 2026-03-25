return {
  "L3MON4D3/LuaSnip",
  event = "InsertEnter",
  build = (require "custom.configs.LuaSnip.build")(),
  dependencies = require "custom.configs.LuaSnip.deps",
  opts = require "custom.configs.LuaSnip.opts",
  config = function(_, opts)
    (require "custom.configs.LuaSnip.config")(_, opts)
  end,
}
