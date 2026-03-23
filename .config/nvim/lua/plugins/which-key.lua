return {
  "folke/which-key.nvim",
  event = "VimEnter",
  config = function()
    require "configs.which-key"
  end,
}
