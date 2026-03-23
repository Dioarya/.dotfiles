return { -- Collection of various small independent plugins/modules
  "nvim-mini/mini.nvim",
  lazy = false,
  config = function()
    require "configs.mini"
  end,
}
