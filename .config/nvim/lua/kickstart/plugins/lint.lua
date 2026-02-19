return {

  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      -- lint.linters_by_ft = {
      --   markdown = { 'markdownlint' },
      -- }

      -- To allow other plugins to add linters to require('lint').linters_by_ft,
      -- instead set linters_by_ft like this:
      lint.linters_by_ft = lint.linters_by_ft or {}
      lint.linters_by_ft['markdown'] = { 'markdownlint' }
      lint.linters_by_ft['python'] = { 'mypy' }

      lint.linters.mypy.args = {
        -- Default args
        '--show-column-numbers',
        '--show-error-end',
        '--hide-error-codes',
        '--hide-error-context',
        '--no-color-output',
        '--no-error-summary',
        '--no-pretty',

        -- -- Custom args
        -- '--no-incremental',  -- no cache files littering inside .mypy_cache
        -- '--python-executable',
        -- 'C:/Program Files/Python312/python.exe',
        -- '--python-version',
        -- '3.12',
        -- '--disallow-untyped-defs',
        -- '--disallow-any-unimported',
        -- '--no-implicit-optional',
        -- '--check-untyped-defs',
        -- '--warn-return-any',
        -- '--warn-unused-ignores',
        -- '--show-error-codes',
        -- '--disallow-any-generics',
        -- '--disallow-any-expr',
      }
      --
      -- However, note that this will enable a set of default linters,
      -- which will cause errors unless these tools are available:
      -- {
      --   clojure = { "clj-kondo" },
      --   dockerfile = { "hadolint" },
      --   inko = { "inko" },
      --   janet = { "janet" },
      --   json = { "jsonlint" },
      --   markdown = { "vale" },
      --   rst = { "vale" },
      --   ruby = { "ruby" },
      --   terraform = { "tflint" },
      --   text = { "vale" }
      -- }
      --
      -- You can disable the default linters by setting their filetypes to nil:
      lint.linters_by_ft['clojure'] = nil
      lint.linters_by_ft['dockerfile'] = nil
      lint.linters_by_ft['inko'] = nil
      lint.linters_by_ft['janet'] = nil
      lint.linters_by_ft['json'] = nil
      lint.linters_by_ft['markdown'] = nil
      lint.linters_by_ft['rst'] = nil
      lint.linters_by_ft['ruby'] = nil
      lint.linters_by_ft['terraform'] = nil
      lint.linters_by_ft['text'] = nil

      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

      -- Only lint with python mypy if autocommand is either "BufEnter" or "BufWritePost"
      -- since mypy can't read within nvim's buffer, and only read from files written on disk.
      local disk_file_linters = { 'mypy' }
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost' }, {
        group = lint_augroup,
        callback = function()
          require('lint').try_lint()
        end,
      })
      vim.api.nvim_create_autocmd({ 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          local linting = true
          local ft_linters = lint._resolve_linter_by_ft(vim.bo.filetype)
          for _, ft_linter in ipairs(ft_linters) do
            for _, disk_file_linter in ipairs(disk_file_linters) do
              if ft_linter == disk_file_linter then
                linting = false
                break
              end
            end
          end
          if linting then
            require('lint').try_lint()
          end
        end,
      })
    end,
  },
}
