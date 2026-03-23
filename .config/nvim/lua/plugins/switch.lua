return {
  "AndrewRadev/switch.vim",
  keys = require "configs.switch.keys",
  config = function()
    require "configs.switch.config"
  end,
  init = function()
    require "configs.switch.initfn"
  end,
}
