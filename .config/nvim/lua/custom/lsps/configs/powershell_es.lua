return function()
  ---@type custom.lsps.ServerConfig
  return {
    -- powershell being the special child breaking the rules of vim.lsp.Config
    bundle_path = vim.fn.expand "$MASON" .. "/packages/powershell-editor-services",
  }
end
