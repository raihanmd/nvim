return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = { "solidity" },
    highlight = { enable = true, additional_vim_regex_highlighting = { "solidity" },
    }
  },
}
