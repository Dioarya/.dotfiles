-- https://www.reddit.com/r/neovim/comments/1sbrnir/comment/oejipjh/
return {
  "nvim-treesitter/nvim-treesitter",
  commit = "90cd658",
  main = "nvim-treesitter",
  -- build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  init = function()
    (require "custom.configs.nvim-treesitter.initfn")()
  end,
  opts = function()
    return require "custom.configs.nvim-treesitter.opts"
  end,
  config = function(_, opts)
    (require "custom.configs.nvim-treesitter.config")(_, opts)
  end,
}
