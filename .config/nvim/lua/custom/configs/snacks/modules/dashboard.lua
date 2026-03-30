local width = 60
local ok, env = pcall(require, "env")

local keys = { section = "keys", align = "center", gap = 1 }
if ok then
  keys = nil
end

local header = { section = "header" }
if ok then
  local width_image = 120
  local height_image = math.floor(width_image / 16 * 9 / 2)
  header = {
    section = "terminal",
    cmd = env.dashboard_terminal_cmd(width_image, height_image),
    indent = -math.floor((width_image - width) / 2),
    width = width_image,
    height = height_image,
    ttl = 0,
  }
end

local startup = { section = "startup" }

local sections = { gap = 1 }
table.insert(sections, header)
table.insert(sections, keys)
table.insert(sections, startup)

local opts = {
  width = width,
  sections = sections,
}

return opts
