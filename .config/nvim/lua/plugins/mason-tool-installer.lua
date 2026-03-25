return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  event = "VeryLazy",
  config = function()
    require "custom.configs.mason-tool-installer.config"
  end,
}
