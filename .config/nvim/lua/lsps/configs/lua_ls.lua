return {
  setup = {
    settings = {
      Lua = {
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
