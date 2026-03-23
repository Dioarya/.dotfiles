return {
  { -- Completely incompatible with nvim-cmp
    "hrsh7th/nvim-cmp",
    enabled = false,
  },

  {
    "saghen/blink.cmp",
    version = "1.*",
    event = { "InsertEnter", "CmdLineEnter" },
    dependencies = require "configs.nvim-blink.deps",
    opts_extend = require "configs.nvim-blink.opts_extend",
    opts = function()
      return require "configs.nvim-blink.opts"
    end,
  },
}
