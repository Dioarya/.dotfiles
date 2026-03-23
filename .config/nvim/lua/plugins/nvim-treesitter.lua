return {
  "nvim-treesitter/nvim-treesitter",
  -- event = { "BufReadPost", "BufNewFile" },
  cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
  build = ":TSUpdate | TSInstallAll",
  opts = require "configs.nvim-treesitter.opts",
  config = function(_, opts)
    (require "configs.nvim-treesitter.config")(_, opts)
  end,
}
