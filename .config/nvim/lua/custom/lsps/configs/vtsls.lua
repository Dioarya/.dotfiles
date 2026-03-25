local vue = require "custom.lsps.shared.vue"

return {
  config = {
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
    },
  },
}
