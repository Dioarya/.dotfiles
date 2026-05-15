local vue = require "custom.lsps.shared.vue"

---@type custom.lsps.ServerConfig
return {
  filetypes = vue.tsserver_filetypes,
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          vue.vue_plugin,
        },
        experimental = {
          enableProjectDiagnostics = true, -- Enables full project check
        },
      },
    },
    typescript = {
      preferences = {
        disableSuggestions = false,
      },
    },
    javascript = {
      preferences = {
        disableSuggestions = false,
      },
    },
  },
}
