return {
  { -- Completely incompatible with nvim-cmp
    "hrsh7th/nvim-cmp",
    enabled = false,
  },

  {
    "saghen/blink.cmp",
    version = "1.*",
    event = { "InsertEnter", "CmdLineEnter" },
    dependencies = require "custom.configs.nvim-blink.deps",
    opts = function()
      return (require "custom.configs.nvim-blink.opts")()
    end,
    opts_extend = require "custom.configs.nvim-blink.opts_extend",
  },
}
