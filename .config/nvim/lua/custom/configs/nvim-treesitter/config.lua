return function(_, opts)
  local treesitter = require "nvim-treesitter"
  treesitter.setup(opts)
  if vim.fn.executable "tree-sitter" ~= 1 then
    vim.notify("tree-sitter CLI not found. Parsers cannot be installed.", vim.log.levels.ERROR, {
      title = "Treesitter",
    })
    return false
  end
  treesitter.install(opts.install)
end
