return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = require "configs.cmp.deps",
  config = function()
    require "configs.cmp.config"
  end,
}
