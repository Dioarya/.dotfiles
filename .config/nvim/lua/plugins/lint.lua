return { -- Linting
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require "configs.lint.config"
  end,
}
