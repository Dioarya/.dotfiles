return {
  {
    -- `snacks.nvim` integration is recommended, but optional
    ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
    "folke/snacks.nvim",
    optional = true,
    opts = {
      input = {}, -- Enhances `ask()`
      picker = { -- Enhances `select()`
        actions = {
          opencode_send = function(...)
            return require("opencode").snacks_picker_send(...)
          end,
        },
        win = {
          input = {
            keys = {
              ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
            },
          },
        },
      },
    },
  },
}
