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
            vim.fn.stdpath "data" .. "/lazy/nvim-tree.lua/lua/nvim-tree",
            vim.fn.stdpath "data" .. "/lazy/gitsigns.nvim/lua/gitsigns/config.lua",
            vim.fn.stdpath "data" .. "/lazy/roslyn.nvim/lua/roslyn/config.lua",
            vim.fn.stdpath "data" .. "/lazy/blink.cmp/lua/blink/cmp/config/types_partial.lua",
            vim.fn.stdpath "data" .. "/lazy/nvim-notify/lua/notify/config/init.lua",
            vim.fn.stdpath "data" .. "/lazy/snacks.nvim/lua/snacks/init.lua",
            "${3rd}/luv/library",
          },
        },
      },
    },
  },
}
