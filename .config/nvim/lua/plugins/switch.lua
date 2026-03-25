return {
  "AndrewRadev/switch.vim",
  keys = require "custom.configs.switch.keys",
  config = function()
    require "custom.configs.switch.config"
  end,
  init = function()
    require "custom.configs.switch.initfn"
  end,
}
