dofile(vim.g.base46_cache .. "nvimtree")

---@type nvim_tree.config
return {
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
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
  },
  modified = {
    enable = true,
  },
  filters = { dotfiles = false },
}
