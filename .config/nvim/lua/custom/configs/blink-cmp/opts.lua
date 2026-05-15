local kind_icons = {
  Namespace = "󰌗",
  Text = "󰉿",
  Method = "󰆧",
  Function = "󰆧",
  Constructor = "",
  Field = "󰜢",
  Variable = "󰀫",
  Class = "󰠱",
  Interface = "",
  Module = "",
  Property = "󰜢",
  Unit = "󰑭",
  Value = "󰎠",
  Enum = "",
  Keyword = "󰌋",
  Snippet = "",
  Color = "󱓻",
  File = "󰈚",
  Reference = "󰈇",
  Folder = "󰉋",
  EnumMember = "",
  Constant = "󰏿",
  Struct = "󰙅",
  Event = "",
  Operator = "󰆕",
  TypeParameter = "󰊄",
  Table = "",
  Object = "󰅩",
  Tag = "",
  Array = "[]",
  Boolean = "",
  Number = "",
  Null = "󰟢",
  Supermaven = "",
  String = "󰉿",
  Calendar = "",
  Watch = "󰥔",
  Package = "",
  Copilot = "",
  Codeium = "",
  TabNine = "",
  BladeNav = "",
}

---@type blink.cmp.WindowBorder
local window_border = "rounded"

---@module 'blink.cmp'
---@type blink.cmp.Config
return {
  enabled = function()
    return true
  end,
  keymap = {
    preset = "default",
    -- ["<CR>"] = { "accept", "fallback" },
    -- ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
    -- ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },

    -- Windows terminal is setup to detect CTRL+SPACE and output ALT+;
    ["<A-;>"] = { "show", "show_documentation", "hide_documentation" },
  },
  completion = {
    ghost_text = { enabled = true },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
      window = { border = window_border },
    },

    -- from nvchad/ui plugin
    -- exporting the ui config of nvchad blink menu
    -- helps non nvchad users
    menu = {
      scrollbar = false,
      border = window_border,
      draw = {
        columns = {
          { "label", "label_description", gap = 1 },
          { "kind_icon", "kind", gap = 1 },
        },
        padding = { 1, 1 },
      },
    },
  },
  fuzzy = { implementation = "prefer_rust" },
  sources = {
    -- add lazydev to your completion providers
    default = { "lazydev", "lsp", "path", "snippets", "buffer" },
    providers = {
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        -- make lazydev completions top priority (see `:h blink.cmp`)
        score_offset = 100,
      },
    },
  },
  signature = {
    enabled = false,
    window = { border = window_border },
  },
  snippets = { preset = "luasnip" },
  appearance = {
    kind_icons = kind_icons,
    nerd_font_variant = "normal",
  },
  cmdline = { enabled = true },
  term = { enabled = true },
}
