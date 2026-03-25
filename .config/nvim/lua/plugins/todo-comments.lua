return {
  "folke/todo-comments.nvim",
  event = "BufReadPost",
  dependencies = require "custom.configs.todo-comments.deps",
  opts = require "custom.configs.todo-comments.opts",
}
