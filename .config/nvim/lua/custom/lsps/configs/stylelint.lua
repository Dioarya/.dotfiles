local fs = require "conform.fs"
local util = require "conform.util"

local config_file_names = {
  -- https://stylelint.io/user-guide/configure/
  ".stylelintrc",
  ".stylelintrc.json",
  ".stylelintrc.yml",
  ".stylelintrc.yaml",
  ".stylelintrc.js",
  "stylelint.config.js",
  "stylelint.config.mjs",
  "stylelint.config.cjs",
  "stylelint.config.ts",
  ".stylelint.config.js",
  ".stylelint.config.mjs",
  ".stylelint.config.cjs",
}

---@type custom.lsps.FormatterConfig
return {
  condition = function(_, ctx)
    return vim.fs.root(ctx.filename, config_file_names) ~= nil
  end,
  command = util.from_node_modules(fs.is_windows and "stylelint.cmd" or "stylelint"),
  args = { "--stdin-filename", "$FILENAME", "--fix", "--allow-empty-input" },
  stdin = true,
}
