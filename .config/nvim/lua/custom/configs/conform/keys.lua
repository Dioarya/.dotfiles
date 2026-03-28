return {
  {
    "<leader>f",
    function()
      require("conform").format { async = true, lsp_fallback = true }
    end,
    mode = "",
    desc = "[F]ormat buffer",
  },
  {
    "<leader>tf",
    function()
      -- If autoformat is currently disabled for this buffer,
      -- then enable it, otherwise disable it
      if vim.b.disable_autoformat then
        vim.cmd "FormatEnable"
        vim.notify "Enabled autoformat for current buffer"
      else
        vim.cmd "FormatDisable!"
        vim.notify "Disabled autoformat for current buffer"
      end
    end,
    desc = "Toggle autoformat for current buffer",
  },
  {
    "<leader>tF",
    function()
      -- If autoformat is currently disabled globally,
      -- then enable it globally, otherwise disable it globally
      if vim.g.disable_autoformat then
        vim.cmd "FormatEnable"
        vim.notify "Enabled autoformat globally"
      else
        vim.cmd "FormatDisable"
        vim.notify "Disabled autoformat globally"
      end
    end,
    desc = "Toggle autoformat globally",
  },
}
