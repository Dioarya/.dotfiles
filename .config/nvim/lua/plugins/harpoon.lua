return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  keys = require "configs.harpoon.keys",
  dependencies = require "configs.harpoon.deps",
  config = function()
    require "configs.harpoon.config"
  end,
}
