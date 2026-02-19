-- File explorer (rarely used, mainly for screensharing)
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  cmd = { "Neotree" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    -- remove background color (ui fix)
    vim.cmd [[hi NeoTreeNormal guibg=none ctermbg=none]]
    vim.cmd [[hi NeoTreeNormalNC guibg=none ctermbg=none]]

    require("neo-tree").setup({
      close_if_last_window = true,
      enable_git_status = true,
      enable_diagnostics = false,

      filesystem = {
        follow_current_file = {
          enabled = true,
        },
        hijack_netrw_behavior = "open_current",
        use_libuv_file_watcher = true,
        filtered_items = {
          visible = true,       -- show hidden files
          hide_dotfiles = false,
        },
      },

      window = {
        position = "right",
                width = 30,

        mappings = {
            ["l"] = "open",
            ["h"] = "close_node",
        },
      },

      default_component_configs = {
        indent = {
          with_markers = true,
        },
        name = {
          use_git_status_colors = true,
        },
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "",
          default = "󰈚",
        },
        git_status = {
          symbols = {
            unmerged = "",
          },
        },
      },
    })
  end,
}
