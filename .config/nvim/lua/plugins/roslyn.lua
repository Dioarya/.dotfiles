return {
  "seblyng/roslyn.nvim",
  dependencies = require "custom.configs.roslyn.deps",
  config = function(_, opts)
    return (require "custom.configs.roslyn.config")(_, opts)
  end,
  opts = require "custom.configs.roslyn.opts",
  ft = "cs",
}
