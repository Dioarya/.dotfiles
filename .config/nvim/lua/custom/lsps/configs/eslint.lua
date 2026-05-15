---@type custom.lsps.ServerConfig
return {
  on_attach = function(_, bufnr)
    -- auto-fix on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
}
