return function(_, _)
  local lint = require "lint"
  local lsps = require "custom.lsps"

  -- linters that cannot read from nvim's in-memory buffer and require a file written to disk.
  -- these are skipped on InsertLeave since the buffer may not reflect disk state.
  local disk_only_linters = { mypy = true }

  -- override linter configs where a custom.lsps.configs.<linter> file exists.
  -- guards against lint.linters[linter] being a factory function rather than a plain table,
  -- in which case we skip the merge and set the config directly.
  for linter, config in pairs(lsps.linters) do
    if type(config) == "function" then
      config = config()
    end
    local existing = lint.linters[linter]
    if type(existing) == "table" then
      lint.linters[linter] = vim.tbl_deep_extend("force", existing, config)
    else
      lint.linters[linter] = config
    end
  end

  -- build filetype -> linters map from lsps.languages.
  lint.linters_by_ft = {} ---@type table<string, string[]>
  for filetype, ft_config in pairs(lsps.languages) do
    if #ft_config.linters > 0 then
      lint.linters_by_ft[filetype] = ft_config.linters
    end
  end

  local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

  -- BufEnter and BufWritePost always lint since the file is known to be in sync with disk
  vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
    group = lint_augroup,
    callback = function()
      lint.try_lint()
    end,
  })

  -- InsertLeave skips any disk-only linters since the buffer may not have been written yet
  vim.api.nvim_create_autocmd({ "InsertLeave" }, {
    group = lint_augroup,
    callback = function()
      local ft_linters = lint._resolve_linter_by_ft(vim.bo.filetype)

      -- check whether all resolved linters for this filetype are disk-only;
      -- if any non-disk linter is present, proceed with linting
      local should_lint = false
      for _, linter in ipairs(ft_linters) do
        if not disk_only_linters[linter] then
          should_lint = true
          break
        end
      end

      if should_lint then
        lint.try_lint()
      end
    end,
  })
end
