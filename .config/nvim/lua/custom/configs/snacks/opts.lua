-- Enable and disable by commenting out stuff, instead of changing the config files.

---@type snacks.Config
local opts = {
  -- animate = { enabled = true },
  bigfile = require "custom.configs.snacks.modules.bigfile",
  -- bufdelete = { enabled = true },
  dashboard = require "custom.configs.snacks.modules.dashboard",
  -- debug = { enabled = true },
  explorer = require "custom.configs.snacks.modules.explorer",
  -- gh = { enabled = true },
  -- git = { enabled = true },
  -- gitbrowse = { enabled = true },
  -- image = require "custom.configs.snacks.modules.image",
  indent = require "custom.configs.snacks.modules.indent",
  input = require "custom.configs.snacks.modules.input",
  -- layout = { enabled = true },
  -- lazygit = { enabled = true },
  notifier = require "custom.configs.snacks.modules.notifier",
  -- notify = { enabled = true },
  picker = require "custom.configs.snacks.modules.picker",
  -- profiler = { enabled = true },
  quickfile = require "custom.configs.snacks.modules.quickfile",
  -- rename = { enabled = true },
  scope = require "custom.configs.snacks.modules.scope",
  -- scratch = { enabled = true },
  -- scroll = require "custom.configs.snacks.modules.scroll",
  -- statuscolumn = require "custom.configs.snacks.modules.statuscolumn",
  -- terminal = { enabled = true },
  -- toggle = { enabled = true },
  -- util = { enabled = true },
  -- win = { enabled = true },
  words = { enabled = true },
  -- zen = { enabled = true },
}

return opts
