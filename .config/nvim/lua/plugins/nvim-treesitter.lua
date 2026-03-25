return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  event = { "BufReadPost", "BufNewFile" },
  -- cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
  build = ":TSUpdate | TSInstallAll",
  opts = require "custom.configs.nvim-treesitter.opts",
  config = function(_, opts)
    (require "custom.configs.nvim-treesitter.config")(_, opts)
  end,
}
