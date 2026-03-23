return {
  "windwp/nvim-ts-autotag",
  event = "InsertEnter",
  opts = require "configs.nvim-ts-autotag.opts",
  per_filetype = require "configs.nvim-ts-autotag.per_filetype",
}
