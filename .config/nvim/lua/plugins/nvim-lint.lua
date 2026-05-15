return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function(_, opts)
    return (require "custom.configs.nvim-lint.config")(_, opts)
  end,
}
