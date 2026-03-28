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
      },
    },
  },
}
