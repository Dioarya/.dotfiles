---@type custom.lsps.ServerConfig
return {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=never",
  },

  root_dir = function(bufnr, on_dir)
    on_dir(vim.fs.root(bufnr, {
      ".clangd",
      "compile_commands.json",
      "compile_flags.txt",
      ".git",
    }))
  end,
}
