-- return require("nvchad.blink").menu
local M = {}
local ui = require("nvconfig").ui.cmp
local atom_styled = ui.style == "atom" or ui.style == "atom_colored"

local menu_cols
if atom_styled or ui.icons_left then
  menu_cols = { { "kind_icon" }, { "label" }, { "kind" } }
else
  menu_cols = { { "label" }, { "kind_icon" }, { "kind" } }
end

M.icons = {}

M.icons.lspkind = {
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

M.components = {
  kind_icon = {
    text = function(ctx)
      local icon = (M.icons.lspkind[ctx.kind] or "󰈚")

      if atom_styled then
        icon = " " .. icon .. " "
      end

      return icon
    end,
  },

  kind = {
    highlight = function(ctx)
      return atom_styled and "comment" or ctx.kind
    end,
  },
}

M.menu = {
  scrollbar = false,
  border = atom_styled and "none" or "single",
  draw = {
    padding = { atom_styled and 0 or 1, 1 },
    columns = menu_cols,
    components = M.components,
  },
}

return M.menu
