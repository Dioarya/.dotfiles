return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  dependencies = require "configs.autopairs.deps",
  config = function()
    require "configs.autopairs.config"
  end,
}
