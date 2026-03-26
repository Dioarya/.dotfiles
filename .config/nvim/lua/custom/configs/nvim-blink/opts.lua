---@module 'blink.cmp'
---@type blink.cmp.Config
return function()
  return {
    snippets = { preset = "luasnip" },
    cmdline = { enabled = true },
    appearance = { nerd_font_variant = "normal" },
    fuzzy = { implementation = "prefer_rust" },
    sources = { default = { "lsp", "snippets", "buffer", "path" } },

    keymap = {
      preset = "default",
      -- ["<CR>"] = { "accept", "fallback" },
      -- ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      -- ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
    },

    completion = {
      ghost_text = { enabled = true },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = { border = "single" },
      },

      -- from nvchad/ui plugin
      -- exporting the ui config of nvchad blink menu
      -- helps non nvchad users
      menu = require "custom.configs.nvim-blink.menu",
    },
  }
end
