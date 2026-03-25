return {
  "folke/which-key.nvim",
  event = "VimEnter",
  config = function()
    require "custom.configs.which-key"
  end,
}
