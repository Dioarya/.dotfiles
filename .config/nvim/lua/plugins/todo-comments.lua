return {
  "folke/todo-comments.nvim",
  event = "BufReadPost",
  dependencies = require "configs.todo-comments.deps",
  opts = require "configs.todo-comments.opts",
}
