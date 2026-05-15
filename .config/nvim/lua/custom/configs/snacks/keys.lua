local modules = require "custom.configs.snacks.modules"
local settings = require "custom.configs.snacks.settings"

---@type table[]
local out = {}
for _, module_name in ipairs(modules) do
  if settings:enabled(module_name) and settings:keys(module_name) then
    local ok, module = pcall(require, "custom.configs.snacks.modules." .. module_name)
    if ok then
      local module_keys = module.keys
      for _, key in ipairs(module_keys) do
        table.insert(out, key)
      end
    end
  end
end

return out
