return {
  config = {
    settings = {
      Lua = {
        runtime = { version = "LuaJIT" },
        completion = {
          callSnippet = "Replace",
        },
        diagnostics = {
          disable = { "missing-fields" },
          globals = { "vim" },
        },
        workspace = {
          library = {
            vim.fn.expand "$VIMRUNTIME/lua",
            vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
            vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
            vim.fn.stdpath "data" .. "/lazy/nvim-tree.lua/lua/nvim-tree/_meta",
            vim.fn.stdpath "data" .. "/lazy/gitsigns.nvim/lua/gitsigns/config.lua",
            "${3rd}/luv/library",
          },
        },
      },
    },
  },
}
