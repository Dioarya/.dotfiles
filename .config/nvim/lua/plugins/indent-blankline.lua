return {
  "lukas-reineke/indent-blankline.nvim",
  event = "User FilePost",
  opts = {
    indent = { char = "│", highlight = "IblChar" },
    scope = { char = "│", highlight = "IblScopeChar" },
  },
  config = function(_, opts)
    dofile(vim.g.base46_cache .. "blankline")

    local hooks = require "ibl.hooks"
    hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
    require("ibl").setup(opts)

    dofile(vim.g.base46_cache .. "blankline")
  end,
}
-- return { -- Add indentation guides even on blank lines
--   "lukas-reineke/indent-blankline.nvim",
--   -- Enable `lukas-reineke/indent-blankline.nvim`
--   -- See `:help ibl`
--   main = "ibl",
--   opts = {},
-- }
