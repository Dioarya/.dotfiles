return {
  {
    "<leader>a",
    function()
      require("harpoon"):list():add()
    end,
    silent = true,
  },
  {
    "<C-e>",
    function()
      require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
    end,
    silent = true,
  },
  {
    "<C-h>",
    function()
      require("harpoon"):list():select(1)
    end,
    silent = true,
  },
  {
    "<C-j>",
    function()
      require("harpoon"):list():select(2)
    end,
    silent = true,
  },
  {
    "<C-k>",
    function()
      require("harpoon"):list():select(3)
    end,
    silent = true,
  },
  {
    "<C-l>",
    function()
      require("harpoon"):list():select(4)
    end,
    silent = true,
  },
  {
    "<C-;>",
    function()
      require("harpoon"):list():select(5)
    end,
    silent = true,
  },
  {
    "<C-'>",
    function()
      require("harpoon"):list():select(6)
    end,
    silent = true,
  },
}
