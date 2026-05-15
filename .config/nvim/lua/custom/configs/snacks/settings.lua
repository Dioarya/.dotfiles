local M = {}

---@class SnacksModuleConfiguration
---@field enabled? boolean the module is enabled
---@field keys? boolean the module's keymappings are enabled
---@field opts? boolean the module has options

---@class SnacksModule
---@field opts table
---@field keys table

---@type table<string, SnacksModuleConfiguration>
local settings = {
  animate = { enabled = true, keys = true },
  bigfile = { enabled = true, keys = true, opts = true },
  bufdelete = { enabled = true, keys = true },
  dashboard = { enabled = true, keys = true, opts = true },
  debug = { enabled = true, keys = true },
  -- dim = { enabled = true, keys = true },
  explorer = { enabled = true, keys = true, opts = true },
  gh = { enabled = true, keys = true },
  git = { enabled = true, keys = true },
  gitbrowse = { enabled = true, keys = true },
  image = { enabled = true, keys = true, opts = true },
  indent = { enabled = true, keys = true },
  input = { enabled = true, keys = true, opts = true },
  keymap = { enabled = true, keys = true },
  layout = { enabled = true, keys = true },
  lazygit = { enabled = true, keys = true },
  notifier = { enabled = true, keys = true, opts = true },
  notify = { enabled = true, keys = true },
  picker = { enabled = true, keys = true, opts = true },
  profiler = { enabled = true, keys = true },
  quickfile = { enabled = true, keys = true, opts = true },
  rename = { enabled = true, keys = true },
  scope = { enabled = true, keys = true, opts = true },
  scratch = { enabled = true, keys = true },
  -- scroll = { enabled = true, keys = true, opts = true },
  -- statuscolumn = { enabled = true, keys = true, opts = true },
  terminal = { enabled = true, keys = true },
  toggle = { enabled = true, keys = true },
  util = { enabled = true, keys = true },
  win = { enabled = true, keys = true },
  words = { enabled = true, keys = true, opts = true },
  zen = { enabled = true, keys = true },

  find = { enabled = true, keys = true },
  lsp = { enabled = true, keys = true },
  search = { enabled = true, keys = true },
}

M.settings = settings

---@param module string
---@return boolean
function M:enabled(module)
  return self.settings[module] ~= nil and self.settings[module].enabled == true
end

---@param module string
---@return boolean
function M:opts(module)
  return self.settings[module] ~= nil and self.settings[module].opts == true
end

---@param module string
---@return boolean
function M:keys(module)
  return self.settings[module] ~= nil and self.settings[module].keys == true
end

return M
