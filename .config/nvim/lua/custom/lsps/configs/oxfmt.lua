local fs = require "conform.fs"
local util = require "conform.util"

local config_file_names = {
  -- https://oxc.rs/docs/guide/usage/formatter/config.html
  ".oxfmtrc.json",
  ".oxfmtrc.jsonc",
  "oxfmt.config.ts",
}

---@type custom.lsps.FormatterConfig
return {
  meta = {
    url = "https://github.com/oxc-project/oxc",
    description = "A Prettier-compatible code formatter.",
  },
  command = util.from_node_modules(fs.is_windows and "oxfmt.cmd" or "oxfmt"),
  args = { "--stdin-filepath", "$FILENAME" },
  stdin = true,
  cwd = require("conform.util").root_file(config_file_names),
}
