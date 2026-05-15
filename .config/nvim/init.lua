vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "custom.configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- if vim.fn.has "win32" == 1 and not vim.fn.has "wsl" == 1 then
--   -- check we're native windows, not MSYS2
--   if os.getenv "MSYSTEM" == nil then
--     vim.env.PATH = "C:/msys64/ucrt64/bin;C:/msys64/usr/bin;" .. vim.env.PATH
--   end
-- end

require "custom.managers.nvchadify"
require "custom.managers.unchadify"
require "custom.managers.runify" -- Main configs load from here

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")
