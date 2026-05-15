local width = 60
---@class CustomENV
---@field dashboard_terminal_cmd fun(width_image: number, height_image: number): string

---@type boolean, CustomENV
local ok, env = pcall(require, "env")

local opts
if ok then
  local width_image = 140
  local height_image = math.floor(width_image / 16 * 9 / 2)

  opts = {
    width = width,
    sections = {
      gap = 1,
      {
        section = "terminal",
        cmd = env.dashboard_terminal_cmd(width_image, height_image),
        indent = -math.floor((width_image - width) / 2),
        width = width_image,
        height = height_image,
        ttl = 0,
      },
      { section = "startup" },
    },
  }
else
  opts = {
    width = width,
    sections = {
      gap = 1,
      { section = "header" },
      { section = "keys", align = "center", gap = 1 },
      { section = "startup" },
    },
  }
end

return opts
