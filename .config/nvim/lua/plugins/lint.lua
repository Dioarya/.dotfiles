return { -- Linting
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require "custom.configs.lint.config"
  end,
}
