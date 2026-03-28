return function(_, opts)
  require("conform").setup(opts)

  vim.api.nvim_create_user_command("FormatDisable", function(args)
    if args.bang then
      -- :FormatDisable! disables autoformat for this buffer only
      vim.b.disable_autoformat = true
    else
      -- :FormatDisable disables autoformat globally
      vim.g.disable_autoformat = true
    end
  end, {
    desc = "Disable autoformat-on-save",
    bang = true, -- allows the ! variant
  })

  vim.api.nvim_create_user_command("FormatEnable", function()
    vim.b.disable_autoformat = false
    vim.g.disable_autoformat = false
  end, {
    desc = "Re-enable autoformat-on-save",
  })
end
