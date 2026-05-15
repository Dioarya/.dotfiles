---@type custom.lsps.relation
local relation_overrides = {
  -- This is additional control for quick enables and disables for specific filetypes and/or servers.

  languages = {
    -- java = false,
  },

  servers = {
    ts_ls = false,
    pyright = false,
    oxlint = false,
  },

  formatters = {
    -- prettier = false,
  },

  daps = {
    -- codelldb = false
  },

  linters = {
    mypy = false,
  },
}

return relation_overrides
