return {
  "nvim-treesitter/nvim-treesitter",
  opts = require "configs.nvim-treesitter.opts",
  config = function(_, opts)
    (require "configs.nvim-treesitter.config")(_, opts)
  end,
}
