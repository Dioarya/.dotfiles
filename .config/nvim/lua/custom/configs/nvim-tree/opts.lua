dofile(vim.g.base46_cache .. "nvimtree")

---@type nvim_tree.config
return {
  on_attach = function(bufnr)
    local api = require "nvim-tree.api"
    local opts = { buffer = bufnr }
    api.map.on_attach.default(bufnr)

    ---@type nvim_tree.api.Node[]
    local path_history = {}

    ---@param path string
    ---@return integer?
    local function find_index(path)
      for i, n in ipairs(path_history) do
        if n.absolute_path == path then
          return i
        end
      end
    end

    local function truncate(from)
      for i = from, #path_history do
        path_history[i] = nil
      end
    end

    ---@param parent nvim_tree.api.Node
    ---@param child nvim_tree.api.Node
    ---@return boolean
    local function is_direct_child(parent, child)
      ---@diagnostic disable-next-line: undefined-field
      return child.parent ~= nil and child.parent.absolute_path == parent.absolute_path
    end

    ---@param node nvim_tree.api.Node
    ---@return nvim_tree.api.Node[]
    local function ancestor_chain(node)
      local chain = {}
      local cur = node
      while cur do
        table.insert(chain, 1, cur)
        ---@diagnostic disable-next-line: undefined-field
        cur = cur.parent
      end
      return chain
    end

    local function capture(parent, child)
      local ancestors = ancestor_chain(parent)

      local common_ph_idx = nil
      local common_anc_idx = nil
      for ai, anc in ipairs(ancestors) do
        local ph_idx = find_index(anc.absolute_path)
        if ph_idx then
          common_ph_idx = ph_idx
          common_anc_idx = ai
        end
      end

      if common_ph_idx then
        local expected_child_ph_idx = common_ph_idx + (#ancestors - common_anc_idx) + 1
        local existing = path_history[expected_child_ph_idx]
        if existing and existing.absolute_path == child.absolute_path then
          return -- still continuous, nothing to do
        end
        truncate(common_ph_idx + 1)
        for i = common_anc_idx + 1, #ancestors do
          path_history[#path_history + 1] = ancestors[i]
        end
      else
        path_history = ancestors
      end

      path_history[#path_history + 1] = child
    end

    local function restore(node)
      local idx = find_index(node.absolute_path)
      if not idx then
        return
      end
      local child = path_history[idx + 1]
      if child and is_direct_child(node, child) then
        api.tree.find_file {
          buf = child.absolute_path,
          open = true,
          focus = true,
        }
      else
        truncate(idx + 1)
      end
    end

    local lefty = function()
      local node = api.tree.get_node_under_cursor()
      if node == nil then
        return
      end

      ---@diagnostic disable-next-line: undefined-field
      if node.nodes then
        ---@cast node nvim_tree.api.DirectoryNode
        if node.open then
          api.node.open.edit()
          return
        end
      end

      api.node.navigate.parent_close()
      local parent = api.tree.get_node_under_cursor()
      if parent then
        capture(parent, node)
      end
    end

    local righty = function()
      local node = api.tree.get_node_under_cursor()
      if node == nil then
        return
      end

      ---@diagnostic disable-next-line: undefined-field
      if node.nodes then
        ---@cast node nvim_tree.api.DirectoryNode
        if not node.open then
          api.node.open.edit()
          restore(node)
        end
      end
    end

    vim.keymap.set("n", "h", lefty, opts)
    vim.keymap.set("n", "<Left>", lefty, opts)
    vim.keymap.set("n", "<Right>", righty, opts)
    vim.keymap.set("n", "l", righty, opts)
  end,
  disable_netrw = true,
  hijack_cursor = true,
  sync_root_with_cwd = true,
  view = {
    centralize_selection = true,
    width = {
      min = 40,
      max = -1,
    },
    side = "right",
    preserve_window_proportions = true,
    float = {
      enable = false,
      open_win_config = {
        relative = "cursor",
        height = 30,
      },
    },
  },
  renderer = {
    root_folder_label = false,
    indent_markers = { enable = true },
    decorators = { "Git", "Open", "Modified", "Hidden", "Bookmark", "Diagnostics", "Copied", "Cut" },
    highlight_git = "none",
    highlight_diagnostics = "all",
    highlight_opened_files = "none",
    highlight_modified = "all",
    highlight_hidden = "icon",
    highlight_bookmarks = "icon",
    highlight_clipboard = "name",
    icons = {
      git_placement = "right_align",
      modified_placement = "after",
      hidden_placement = "after",
      diagnostics_placement = "signcolumn",
      bookmarks_placement = "signcolumn",
      padding = {
        icon = " ",
      },
      show = {
        hidden = true,
      },
      glyphs = {
        default = "󰈚",
        folder = {
          default = "",
          empty = "",
          empty_open = "",
          open = "",
          symlink = "",
        },
        git = { unmerged = "" },
      },
    },
  },
  update_focused_file = {
    enable = true,
    update_root = {
      enable = true,
    },
  },
  git = {
    enable = true,
    cygwin_support = true,
    show_on_open_dirs = false,
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    show_on_open_dirs = false,
  },
  modified = {
    enable = true,
    show_on_open_dirs = false,
  },
  filters = { dotfiles = false },
}
