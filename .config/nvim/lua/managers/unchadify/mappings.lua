-- never call this FUCKtion ever.
local _ = function()
  local map = vim.keymap.set

  map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
  map("i", "<C-e>", "<End>", { desc = "move end of line" })
  map("i", "<C-h>", "<Left>", { desc = "move left" })
  map("i", "<C-l>", "<Right>", { desc = "move right" })
  map("i", "<C-j>", "<Down>", { desc = "move down" })
  map("i", "<C-k>", "<Up>", { desc = "move up" })

  map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
  map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
  map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
  map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

  map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })

  map("n", "<C-s>", "<cmd>w<CR>", { desc = "general save file" })
  map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "general copy whole file" })

  map("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "toggle line number" })
  map("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "toggle relative number" })
  map("n", "<leader>ch", "<cmd>NvCheatsheet<CR>", { desc = "toggle nvcheatsheet" })

  map({ "n", "x" }, "<leader>fm", function()
    require("conform").format { lsp_fallback = true }
  end, { desc = "general format file" })

  -- global lsp mappings
  map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "LSP diagnostic loclist" })

  -- tabufline
  if require("nvconfig").ui.tabufline.enabled then
    map("n", "<leader>b", "<cmd>enew<CR>", { desc = "buffer new" })

    map("n", "<tab>", function()
      require("nvchad.tabufline").next()
    end, { desc = "buffer goto next" })

    map("n", "<S-tab>", function()
      require("nvchad.tabufline").prev()
    end, { desc = "buffer goto prev" })

    map("n", "<leader>x", function()
      require("nvchad.tabufline").close_buffer()
    end, { desc = "buffer close" })
  end

  -- Comment
  map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
  map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })

  -- nvimtree
  map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
  map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })

  -- telescope
  map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
  map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
  map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
  map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
  map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
  map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "telescope find in current buffer" })
  map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
  map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
  map("n", "<leader>pt", "<cmd>Telescope terms<CR>", { desc = "telescope pick hidden term" })

  map("n", "<leader>th", function()
    require("nvchad.themes").open()
  end, { desc = "telescope nvchad themes" })

  map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
  map(
    "n",
    "<leader>fa",
    "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
    { desc = "telescope find all files" }
  )

  -- terminal
  map("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })

  -- new terminals
  map("n", "<leader>h", function()
    require("nvchad.term").new { pos = "sp" }
  end, { desc = "terminal new horizontal term" })

  map("n", "<leader>v", function()
    require("nvchad.term").new { pos = "vsp" }
  end, { desc = "terminal new vertical term" })

  -- toggleable
  map({ "n", "t" }, "<A-v>", function()
    require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
  end, { desc = "terminal toggleable vertical term" })

  map({ "n", "t" }, "<A-h>", function()
    require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
  end, { desc = "terminal toggleable horizontal term" })

  map({ "n", "t" }, "<A-i>", function()
    require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
  end, { desc = "terminal toggle floating term" })

  -- whichkey
  map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })

  map("n", "<leader>wk", function()
    vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
  end, { desc = "whichkey query lookup" })
end

local del = vim.keymap.del

-- map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
del("i", "<C-b>")
-- map("i", "<C-e>", "<End>", { desc = "move end of line" })
del("i", "<C-e>")
-- map("i", "<C-h>", "<Left>", { desc = "move left" })
del("i", "<C-h>")
-- map("i", "<C-l>", "<Right>", { desc = "move right" })
del("i", "<C-l>")
-- map("i", "<C-j>", "<Down>", { desc = "move down" })
del("i", "<C-j>")
-- map("i", "<C-k>", "<Up>", { desc = "move up" })
del("i", "<C-k>")

-- map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
del("n", "<C-h>")
-- map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
del("n", "<C-l>")
-- map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
del("n", "<C-j>")
-- map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })
del("n", "<C-k>")

-- map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })
del("n", "<Esc>")

-- map("n", "<C-s>", "<cmd>w<CR>", { desc = "general save file" })
del("n", "<C-s>")
-- map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "general copy whole file" })
del("n", "<C-c>")

-- map("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "toggle line number" })
del("n", "<leader>n")
-- map("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "toggle relative number" })
del("n", "<leader>rn")
-- map("n", "<leader>ch", "<cmd>NvCheatsheet<CR>", { desc = "toggle nvcheatsheet" })
del("n", "<leader>ch")

-- map({ "n", "x" }, "<leader>fm", function() require("conform").format { lsp_fallback = true } end, { desc = "general format file" })
del({ "n", "x" }, "<leader>fm")

-- global lsp mappings
-- map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "LSP diagnostic loclist" })
del("n", "<leader>ds")

-- tabufline
if require("nvconfig").ui.tabufline.enabled then
  -- map("n", "<leader>b", "<cmd>enew<CR>", { desc = "buffer new" })
  del("n", "<leader>b")

  -- map("n", "<tab>", function() require("nvchad.tabufline").next() end, { desc = "buffer goto next" })
  del("n", "<tab>")

  -- map("n", "<S-tab>", function() require("nvchad.tabufline").prev() end, { desc = "buffer goto prev" })
  del("n", "<S-tab>")

  -- map("n", "<leader>x", function() require("nvchad.tabufline").close_buffer() end, { desc = "buffer close" })
  del("n", "<leader>x")
end

-- Comment
-- map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
del("n", "<leader>/")
-- map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })
del("v", "<leader>/")

-- nvimtree
-- map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
del("n", "<C-n>")
-- map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })
del("n", "<leader>e")

-- telescope
-- map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
del("n", "<leader>fw")
-- map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
del("n", "<leader>fb")
-- map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
del("n", "<leader>fh")
-- map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
del("n", "<leader>ma")
-- map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
del("n", "<leader>fo")
-- map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "telescope find in current buffer" })
del("n", "<leader>fz")
-- map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
del("n", "<leader>cm")
-- map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
del("n", "<leader>gt")
-- map("n", "<leader>pt", "<cmd>Telescope terms<CR>", { desc = "telescope pick hidden term" })
del("n", "<leader>pt")

-- map("n", "<leader>th", function() require("nvchad.themes").open() end, { desc = "telescope nvchad themes" })
del("n", "<leader>th")

-- map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
del("n", "<leader>ff")
-- map("n", "<leader>fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>", { desc = "telescope find all files" })
del("n", "<leader>fa")

-- terminal
-- map("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })
del("t", "<C-x>")

-- new terminals
-- map("n", "<leader>h", function() require("nvchad.term").new { pos = "sp" } end, { desc = "terminal new horizontal term" })
del("n", "<leader>h")

-- map("n", "<leader>v", function() require("nvchad.term").new { pos = "vsp" } end, { desc = "terminal new vertical term" })
del("n", "<leader>v")

-- toggleable
-- map({ "n", "t" }, "<A-v>", function() require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" } end, { desc = "terminal toggleable vertical term" })
del({ "n", "t" }, "<A-v>")

-- map({ "n", "t" }, "<A-h>", function() require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" } end, { desc = "terminal toggleable horizontal term" })
del({ "n", "t" }, "<A-h>")

-- map({ "n", "t" }, "<A-i>", function() require("nvchad.term").toggle { pos = "float", id = "floatTerm" } end, { desc = "terminal toggle floating term" })
del({ "n", "t" }, "<A-i>")

-- whichkey
-- map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })
del("n", "<leader>wK")

-- map("n", "<leader>wk", function() vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ") end, { desc = "whichkey query lookup" })
del("n", "<leader>wk")
