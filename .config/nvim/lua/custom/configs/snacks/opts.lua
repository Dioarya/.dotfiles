local modules = require "custom.configs.snacks.modules"
local settings = require "custom.configs.snacks.settings"

---@type table[]
local out = {}
for _, module_name in ipairs(modules) do
  if settings:enabled(module_name) and settings:opts(module_name) then
    ---@type boolean, SnacksModule
    local ok, module = pcall(require, "custom.configs.snacks.modules." .. module_name)
    if ok then
      local opts = module.opts
      out[module_name] = opts
    end
  end
end

return out
