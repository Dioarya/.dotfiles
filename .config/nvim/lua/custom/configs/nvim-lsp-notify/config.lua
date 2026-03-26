return function(_, opts)
  require("lsp-notify").setup {
    notify = require "notify",
    icons = false,
    disable = {
      progress = false,
      show_message = true,
    },
  }
end
