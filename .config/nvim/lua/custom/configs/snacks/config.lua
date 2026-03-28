return function(_, opts)
  local snacks = require "snacks"
  snacks.setup(opts)

  -- Load autocommands
  require "custom.configs.snacks.autocmds"
end
