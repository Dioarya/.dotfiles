return function()
  local highlight = function(bufnr, lang)
    -------------------[ treesitter highlights ]-------------------------------
    if not vim.treesitter.language.add(lang) then
      return vim.notify(
        string.format("Treesitter cannot load parser for language: %s", lang),
        vim.log.levels.INFO,
        { title = "Treesitter" }
      )
    end
    vim.treesitter.start(bufnr)
  end

  vim.api.nvim_create_autocmd({ "FileType" }, {
    callback = function(args)
      local ft = vim.bo[args.buf].filetype
      local bt = vim.bo[args.buf].buftype
      local buf = args.buf

      if ft == "" or bt ~= "" then
        return
      end -- don't run further.

      local ok, treesitter = pcall(require, "nvim-treesitter")
      if not ok then
        return
      end

      -- translate filetype to treesitter language key, falling back to ft if no mapping exists
      local lang = vim.treesitter.language.get_lang(ft) or ft

      ---------------------[ treesitter indent ]-------------------------------

      if not vim.tbl_contains({ "python", "html", "yaml", "markdown", "ruby" }, ft) then
        vim.bo[buf].indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
      end

      --------------------[ treesitter parsers ]-------------------------------

      if vim.fn.executable "tree-sitter" ~= 1 then
        vim.notify("tree-sitter CLI not found. Parsers cannot be installed.", vim.log.levels.ERROR, {
          title = "Treesitter",
        })
        return false
      end

      if not lang then
        return
      end

      if vim.list_contains(treesitter.get_installed(), lang) then
        highlight(buf, lang)
      elseif vim.list_contains(treesitter.get_available(), lang) then
        treesitter.install(lang):await(function()
          highlight(buf, lang)
        end)
      end
    end,
  })
end
