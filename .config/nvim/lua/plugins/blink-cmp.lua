return {
  { -- Completely incompatible with nvim-cmp
    "hrsh7th/nvim-cmp",
    enabled = false,
  },

  {
    "saghen/blink.cmp",
    version = "1.*",
    event = { "InsertEnter", "CmdLineEnter" },
    dependencies = require "custom.configs.blink-cmp.deps",
    opts = require "custom.configs.blink-cmp.opts",
  },
}
