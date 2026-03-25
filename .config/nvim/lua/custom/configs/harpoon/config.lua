local harpoon = require "harpoon"
local keys = require "custom.configs.harpoon.keys"

harpoon:setup()

vim.keymap.set("n", keys[1], function()
  harpoon:list():add()
end)

vim.keymap.set("n", keys[2], function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end)

for i = 3, #keys do
  local idx = i - 2
  vim.keymap.set("n", keys[i], function()
    harpoon:list():select(idx)
  end)
end
