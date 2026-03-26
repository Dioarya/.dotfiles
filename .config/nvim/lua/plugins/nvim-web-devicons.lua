return {
  "nvim-tree/nvim-web-devicons",
  enabled = vim.g.have_nerd_font,
  opts = function()
    dofile(vim.g.base46_cache .. "devicons")
    return { override = require "nvchad.icons.devicons" }
  end,
}
