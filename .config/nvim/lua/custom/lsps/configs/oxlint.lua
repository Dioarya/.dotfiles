---@type custom.lsps.ServerConfig
return {
  cmd = function(dispatchers, config)
    local cmd = "oxlint"
    if (config or {}).root_dir then
      local ext = (vim.fn.has "win32" == 1) and ".cmd" or ""
      local local_cmd = vim.fs.joinpath(config.root_dir, "node_modules/.bin", cmd .. ext)
      if vim.fn.executable(local_cmd) == 1 then
        cmd = local_cmd
      end
    end
    return vim.lsp.rpc.start({ cmd, "--lsp" }, dispatchers)
  end,
}
