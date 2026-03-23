return function()
  local custom_switches = vim.api.nvim_create_augroup("custom-switches", { clear = true })
  vim.api.nvim_create_autocmd("FileType", {
    group = custom_switches,
    pattern = { "gitrebase" },
    callback = function()
      vim.b["switch_custom_definitions"] = {
        { "pick", "reword", "edit", "squash", "fixup", "exec", "drop" },
      }
    end,
  })
  -- (un)check markdown buxes
  vim.api.nvim_create_autocmd("FileType", {
    group = custom_switches,
    pattern = { "markdown" },
    callback = function()
      local fk = [=[\v^(\s*[*+-] )?\[ \]]=]
      local sk = [=[\v^(\s*[*+-] )?\[x\]]=]
      local tk = [=[\v^(\s*[*+-] )?\[-\]]=]
      local fok = [=[\v^(\s*\d+\. )?\[ \]]=]
      local fik = [=[\v^(\s*\d+\. )?\[x\]]=]
      local sik = [=[\v^(\s*\d+\. )?\[-\]]=]
      vim.b["switch_custom_definitions"] = {
        {
          [fk] = [=[\1[x]]=],
          [sk] = [=[\1[-]]=],
          [tk] = [=[\1[ ]]=],
        },
        {
          [fok] = [=[\1[x]]=],
          [fik] = [=[\1[-]]=],
          [sik] = [=[\1[ ]]=],
        },
      }
    end,
  })
end
