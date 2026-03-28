return {
  "hrsh7th/nvim-cmp",
  enabled = false,
  event = "InsertEnter",
  dependencies = require "custom.configs.nvim-cmp.deps",
  config = function()
    require "custom.configs.nvim-cmp.config"
  end,
}
