local map = vim.keymap.set

-- Set highlight on search, but clear on pressing <Esc> in normal mode
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
map("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
map("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
map("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
map("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
-- map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map("n", "\\", function()
  local view = require "nvim-tree.view"
  if view.is_visible() then
    if vim.bo.filetype == "NvimTree" then
      vim.cmd "NvimTreeClose"
    else
      vim.cmd "NvimTreeFocus"
    end
  else
    local buf = vim.api.nvim_buf_get_name(0)
    if buf == "" then
      vim.cmd "NvimTreeToggle"
    else
      vim.cmd "NvimTreeFindFile"
    end
  end
end, { desc = "nvimtree reveal" })

map("n", "gC", "<cmd>CccPick<CR>")
