local function map_desc(mode, key, func, desc)
  vim.keymap.set(mode, key, func, { noremap = true, silent = true, desc = desc })
end

map_desc("n", "<leader>mp", "<CMD>MarkdownPreviewToggle<CR>", "Markdown Preview Toggle")
